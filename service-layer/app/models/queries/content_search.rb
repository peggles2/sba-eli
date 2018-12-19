module Queries
  class ContentSearch < Queries::SqlBase
    def initialize(params)
      super(params)
    end

    def call
      SearchResult.paginate_by_sql(sql, page: page, per_page: per_page)
    end

    private

    # This method prepares incoming peramters to be utilized in constructing the
    # SQL to be executed.
    def prepare(params)
      check_like_value(:keywords, params)
      check_array_value(:subjects, params)
      check_array_value(:media_types, params)
      check_array_value(:durations, params)
      check_single_value(:account_id, params)
      check_numeric_value(:per_page, params, 20)
      check_numeric_value(:page, params, 1)
      check_single_value(:workflow_state, params, "active")
    end

    # Constructs the SQL to be executed.
    def sql
      <<-SQL
        -- Search learning paths
        SELECT DISTINCT
          c.id,
          c.name,
          c.course_code,
          c.settings,
          cc.content,
          'learning_path' AS content_type,
          c.id AS learning_path_id,
          0 AS learning_objective_id
        FROM courses c
          LEFT OUTER JOIN fearless_taggings ts
            ON ts.taggable_id = c.id AND ts.taggable_type = 'LearningPath'
          LEFT OUTER JOIN fearless_tags t
            ON t.id = ts.tag_id
          LEFT OUTER JOIN fearless_custom_contents cc
            ON cc.contentable_id = c.id AND cc.contentable_type = 'LearningPath'
        WHERE 0=0
          #{construct_account_clause}
          #{construct_course_worklow_clause}
          #{construct_name_sql}
          #{construct_all_tags_serach('t', 'name')}
        UNION ALL
        -- Search learning objectives
        SELECT DISTINCT
          cm.id,
          cm.name,
          c.course_code,
          c.settings,
          cc.content,
          'learning_objective' AS content_type,
          cm.context_id::bigint AS learning_path_id,
          cm.id::bigint AS learning_objective_id
        FROM context_modules cm
          INNER JOIN courses c
            ON c.id = cm.context_id
              AND cm.context_type = 'Course'
          LEFT OUTER JOIN fearless_taggings ts
            ON ts.taggable_id = cm.id AND ts.taggable_type = 'LearningObjective'
          LEFT OUTER JOIN fearless_tags t
            ON t.id = ts.tag_id
          LEFT OUTER JOIN fearless_custom_contents cc
            ON cc.contentable_id = cm.id AND cc.contentable_type = 'LearningObjective'
        WHERE 0=0
          #{construct_account_clause}
          #{construct_generic_workflow_clause('cm')}
          #{construct_name_sql('cm')}
          #{construct_all_tags_serach('t', 'name')}
        UNION ALL
        -- Search learning learning_event
        SELECT DISTINCT
          ct.id,
          ct.title AS name,
          c.course_code,
          c.settings,
          cc.content,
          'learning_event' AS content_type,
          ct.context_id::bigint AS learning_path_id,
          ct.context_module_id::bigint AS learning_objective_id
        FROM content_tags ct
          INNER JOIN courses c
            ON c.id = ct.context_id
              AND ct.context_type = 'Course'
          LEFT OUTER JOIN fearless_taggings ts
            ON ts.taggable_id = ct.id AND ts.taggable_type = 'LearningEvent'
          LEFT OUTER JOIN fearless_tags t
            ON t.id = ts.tag_id
          LEFT OUTER JOIN fearless_custom_contents cc
            ON cc.contentable_id = ct.id AND cc.contentable_type = 'LearningEvent'
        WHERE 0=0
          #{construct_account_clause}
          #{construct_generic_workflow_clause('ct')}
          #{construct_name_sql('ct', 'title')}
          #{construct_all_tags_serach('t', 'name')}
      SQL
    end

    # contructs the SQL to search for custom tags within the database. These are
    # used for searching durations, media_types and subjects
    def construct_all_tags_serach(table, field)
      sql_array = [subjects, media_types, durations].map { |a| a if a.any? }.compact
      sql_strings = sql_array.map do |values|
        "(#{construct_tag_search(table, field, values)})"
      end
      "AND " + sql_strings.join(" AND ") unless sql_strings.empty?
    end

    # Constructs sql to search a specific canvas account
    def construct_account_clause(table = "c")
      "AND #{table}.account_id = #{sanitize(account_id)}" if account_id.present?
    end

    # Constructs sql to search for a given workflow status (active state 'available')
    def construct_course_worklow_clause
      if workflow_state == "active"
        "AND c.workflow_state = 'available'"
      else
        "AND c.workflow_state != 'available'"
      end
    end

    # Constructs sql to search for a given workflow status (active state 'active')
    def construct_generic_workflow_clause(table)
      if workflow_state == "active"
        "AND #{table}.workflow_state = 'active'"
      else
        "AND #{table}.workflow_state != 'active'"
      end
    end

    # Generates SQL for non-casse sensitive search
    def construct_ilike_search(table, field, value, concat = "AND")
      "#{concat} #{table}.#{field} ILIKE '#{sanitize(value)}'" if value.present?
    end

    def construct_name_sql(table = "c", field = "name")
      construct_ilike_search(table, field, keywords)
    end

    # Generates SQL to search for custom tags
    def construct_tag_search(table, field, values)
      values.map { |v| construct_ilike_search(table, field, v, "") }.join(" OR ")
    end
  end
end
