# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_01_180344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "abstract_courses", force: :cascade do |t|
    t.string "sis_source_id", limit: 255
    t.bigint "sis_batch_id"
    t.bigint "account_id", null: false
    t.bigint "root_account_id", null: false
    t.string "short_name", limit: 255
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "enrollment_term_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.text "stuck_sis_fields"
    t.index ["enrollment_term_id"], name: "index_abstract_courses_on_enrollment_term_id"
    t.index ["root_account_id", "sis_source_id"], name: "index_abstract_courses_on_root_account_id_and_sis_source_id"
    t.index ["sis_batch_id"], name: "index_abstract_courses_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["sis_source_id"], name: "index_abstract_courses_on_sis_source_id"
  end

  create_table "access_tokens", force: :cascade do |t|
    t.bigint "developer_key_id", null: false
    t.bigint "user_id"
    t.datetime "last_used_at"
    t.datetime "expires_at"
    t.string "purpose", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_token", limit: 255
    t.string "token_hint", limit: 255
    t.text "scopes"
    t.boolean "remember_access"
    t.string "crypted_refresh_token", limit: 255
    t.string "workflow_state", default: "active", null: false
    t.index ["crypted_refresh_token"], name: "index_access_tokens_on_crypted_refresh_token", unique: true
    t.index ["crypted_token"], name: "index_access_tokens_on_crypted_token", unique: true
    t.index ["developer_key_id", "last_used_at"], name: "index_access_tokens_on_developer_key_id_and_last_used_at"
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
    t.index ["workflow_state"], name: "index_access_tokens_on_workflow_state"
  end

  create_table "account_notification_roles", force: :cascade do |t|
    t.bigint "account_notification_id", null: false
    t.bigint "role_id"
    t.index ["account_notification_id", "role_id"], name: "index_account_notification_roles_on_role_id", unique: true
  end

  create_table "account_notifications", force: :cascade do |t|
    t.string "subject", limit: 255
    t.string "icon", limit: 255, default: "warning"
    t.text "message"
    t.bigint "account_id", null: false
    t.bigint "user_id"
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "required_account_service", limit: 255
    t.integer "months_in_display_cycle"
    t.boolean "domain_specific", default: false, null: false
    t.index ["account_id", "end_at", "start_at"], name: "index_account_notifications_by_account_and_timespan"
    t.index ["user_id"], name: "index_account_notifications_on_user_id"
  end

  create_table "account_report_rows", force: :cascade do |t|
    t.bigint "account_report_id", null: false
    t.bigint "account_report_runner_id", null: false
    t.integer "row_number"
    t.string "row", default: [], array: true
    t.datetime "created_at", null: false
    t.index ["account_report_id"], name: "index_account_report_rows_on_account_report_id"
    t.index ["account_report_runner_id"], name: "index_account_report_rows_on_account_report_runner_id"
  end

  create_table "account_report_runners", force: :cascade do |t|
    t.bigint "account_report_id", null: false
    t.string "workflow_state", limit: 255, default: "created", null: false
    t.string "batch_items", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.index ["account_report_id"], name: "index_account_report_runners_on_account_report_id"
  end

  create_table "account_reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "message"
    t.bigint "account_id", null: false
    t.bigint "attachment_id"
    t.string "workflow_state", limit: 255, default: "created", null: false
    t.string "report_type", limit: 255
    t.integer "progress"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "parameters"
    t.integer "current_line"
    t.integer "total_lines"
    t.datetime "start_at"
    t.datetime "end_at"
    t.index ["account_id", "report_type", "updated_at"], name: "index_account_reports_latest_per_account", order: { updated_at: :desc }
    t.index ["attachment_id"], name: "index_account_reports_on_attachment_id"
    t.index ["user_id"], name: "index_account_reports_on_user_id"
  end

  create_table "account_users", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "role_id", null: false
    t.string "workflow_state", default: "active", null: false
    t.bigint "sis_batch_id"
    t.index ["account_id"], name: "index_account_users_on_account_id"
    t.index ["sis_batch_id"], name: "index_account_users_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["user_id"], name: "index_account_users_on_user_id"
    t.index ["workflow_state"], name: "index_account_users_on_workflow_state"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "deleted_at"
    t.bigint "parent_account_id"
    t.string "sis_source_id", limit: 255
    t.bigint "sis_batch_id"
    t.bigint "current_sis_batch_id"
    t.bigint "root_account_id"
    t.bigint "last_successful_sis_batch_id"
    t.string "membership_types", limit: 255
    t.string "default_time_zone", limit: 255
    t.string "external_status", limit: 255, default: "active"
    t.bigint "storage_quota"
    t.bigint "default_storage_quota"
    t.boolean "enable_user_notes", default: false
    t.string "allowed_services", limit: 255
    t.text "turnitin_pledge"
    t.text "turnitin_comments"
    t.string "turnitin_account_id", limit: 255
    t.string "turnitin_salt", limit: 255
    t.string "turnitin_crypted_secret", limit: 255
    t.boolean "show_section_name_as_course_name", default: false
    t.boolean "allow_sis_import", default: false
    t.string "equella_endpoint", limit: 255
    t.text "settings"
    t.string "uuid", limit: 255
    t.string "default_locale", limit: 255
    t.text "stuck_sis_fields"
    t.bigint "default_user_storage_quota"
    t.string "lti_guid", limit: 255
    t.bigint "default_group_storage_quota"
    t.string "turnitin_host", limit: 255
    t.string "integration_id", limit: 255
    t.string "lti_context_id", limit: 255
    t.string "brand_config_md5", limit: 32
    t.string "turnitin_originality", limit: 255
    t.bigint "latest_outcome_import_id"
    t.index ["brand_config_md5"], name: "index_accounts_on_brand_config_md5", where: "(brand_config_md5 IS NOT NULL)"
    t.index ["integration_id", "root_account_id"], name: "index_accounts_on_integration_id", unique: true, where: "(integration_id IS NOT NULL)"
    t.index ["lti_context_id"], name: "index_accounts_on_lti_context_id", unique: true
    t.index ["name", "parent_account_id"], name: "index_accounts_on_name_and_parent_account_id"
    t.index ["parent_account_id", "root_account_id"], name: "index_accounts_on_parent_account_id_and_root_account_id"
    t.index ["root_account_id"], name: "index_accounts_on_root_account_id"
    t.index ["sis_batch_id"], name: "index_accounts_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["sis_source_id", "root_account_id"], name: "index_accounts_on_sis_source_id_and_root_account_id", unique: true, where: "(sis_source_id IS NOT NULL)"
  end

  create_table "alert_criteria", force: :cascade do |t|
    t.bigint "alert_id"
    t.string "criterion_type", limit: 255
    t.float "threshold"
  end

  create_table "alerts", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.text "recipients", null: false
    t.integer "repetition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "anonymous_or_moderation_events", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "user_id", null: false
    t.bigint "submission_id"
    t.bigint "canvadoc_id"
    t.string "event_type", null: false
    t.jsonb "payload", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_anonymous_or_moderation_events_on_assignment_id"
    t.index ["canvadoc_id"], name: "index_anonymous_or_moderation_events_on_canvadoc_id"
    t.index ["submission_id"], name: "index_anonymous_or_moderation_events_on_submission_id"
    t.index ["user_id"], name: "index_anonymous_or_moderation_events_on_user_id"
  end

  create_table "appointment_group_contexts", force: :cascade do |t|
    t.bigint "appointment_group_id"
    t.string "context_code", limit: 255
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_group_id"], name: "index_appointment_group_contexts_on_appointment_group_id"
  end

  create_table "appointment_group_sub_contexts", force: :cascade do |t|
    t.bigint "appointment_group_id"
    t.bigint "sub_context_id"
    t.string "sub_context_type", limit: 255
    t.string "sub_context_code", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_group_id"], name: "index_appointment_group_sub_contexts_on_appointment_group_id"
  end

  create_table "appointment_groups", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.string "location_name", limit: 255
    t.string "location_address", limit: 255
    t.string "context_code", limit: 255
    t.string "sub_context_code", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "participants_per_appointment"
    t.integer "max_appointments_per_participant"
    t.integer "min_appointments_per_participant", default: 0
    t.string "participant_visibility", limit: 255
  end

  create_table "assessment_question_bank_users", force: :cascade do |t|
    t.bigint "assessment_question_bank_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assessment_question_bank_id"], name: "assessment_qbu_aqb_id"
    t.index ["user_id"], name: "assessment_qbu_u_id"
  end

  create_table "assessment_question_banks", force: :cascade do |t|
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.text "title"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "migration_id", limit: 255
    t.index ["context_id", "context_type"], name: "index_on_aqb_on_context_id_and_context_type"
  end

  create_table "assessment_questions", force: :cascade do |t|
    t.text "name"
    t.text "question_data"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.string "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "assessment_question_bank_id"
    t.datetime "deleted_at"
    t.string "migration_id", limit: 255
    t.integer "position"
    t.index ["assessment_question_bank_id", "position"], name: "question_bank_id_and_position"
  end

  create_table "assessment_requests", force: :cascade do |t|
    t.bigint "rubric_assessment_id"
    t.bigint "user_id", null: false
    t.bigint "asset_id", null: false
    t.string "asset_type", limit: 255, null: false
    t.bigint "assessor_asset_id", null: false
    t.string "assessor_asset_type", limit: 255, null: false
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uuid", limit: 255
    t.bigint "rubric_association_id"
    t.bigint "assessor_id", null: false
    t.index ["assessor_asset_id", "assessor_asset_type"], name: "aa_id_and_aa_type"
    t.index ["assessor_id"], name: "index_assessment_requests_on_assessor_id"
    t.index ["asset_id", "asset_type"], name: "index_assessment_requests_on_asset_id_and_asset_type"
    t.index ["rubric_assessment_id"], name: "index_assessment_requests_on_rubric_assessment_id"
    t.index ["rubric_association_id"], name: "index_assessment_requests_on_rubric_association_id"
    t.index ["user_id"], name: "index_assessment_requests_on_user_id"
  end

  create_table "asset_user_accesses", force: :cascade do |t|
    t.string "asset_code", limit: 255
    t.string "asset_group_code", limit: 255
    t.bigint "user_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.datetime "last_access"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "asset_category", limit: 255
    t.float "view_score"
    t.float "participate_score"
    t.string "action_level", limit: 255
    t.text "display_name"
    t.string "membership_type", limit: 255
    t.index ["context_id", "context_type", "user_id", "updated_at"], name: "index_asset_user_accesses_on_ci_ct_ui_ua"
    t.index ["user_id", "asset_code"], name: "index_asset_user_accesses_on_user_id_and_asset_code"
  end

  create_table "assignment_configuration_tool_lookups", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "tool_id"
    t.string "tool_type", limit: 255, null: false
    t.string "subscription_id"
    t.string "tool_product_code"
    t.string "tool_vendor_code"
    t.string "tool_resource_type_code"
    t.index ["assignment_id"], name: "index_assignment_configuration_tool_lookups_on_assignment_id"
    t.index ["tool_id", "tool_type", "assignment_id"], name: "index_tool_lookup_on_tool_assignment_id", unique: true
    t.index ["tool_product_code", "tool_vendor_code", "tool_resource_type_code"], name: "index_resource_codes_on_assignment_configuration_tool_lookups"
  end

  create_table "assignment_groups", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "rules"
    t.string "default_assignment_name", limit: 255
    t.integer "position"
    t.string "assignment_weighting_scheme", limit: 255
    t.float "group_weight"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "cloned_item_id"
    t.string "context_code", limit: 255
    t.string "migration_id", limit: 255
    t.string "sis_source_id", limit: 255
    t.text "integration_data"
    t.index ["context_id", "context_type"], name: "index_assignment_groups_on_context_id_and_context_type"
  end

  create_table "assignment_override_students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assignment_id"
    t.bigint "assignment_override_id", null: false
    t.bigint "user_id", null: false
    t.bigint "quiz_id"
    t.string "workflow_state", default: "active", null: false
    t.index ["assignment_id", "user_id"], name: "index_assignment_override_students_on_assignment_id_and_user_id", unique: true, where: "((workflow_state)::text = 'active'::text)"
    t.index ["assignment_override_id"], name: "index_assignment_override_students_on_assignment_override_id"
    t.index ["quiz_id"], name: "index_assignment_override_students_on_quiz_id"
    t.index ["user_id", "quiz_id"], name: "index_assignment_override_students_on_user_id_and_quiz_id"
    t.index ["user_id"], name: "index_assignment_override_students_on_user_id"
    t.index ["workflow_state"], name: "index_assignment_override_students_on_workflow_state"
  end

  create_table "assignment_overrides", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assignment_id"
    t.integer "assignment_version"
    t.string "set_type", limit: 255
    t.bigint "set_id"
    t.string "title", limit: 255, null: false
    t.string "workflow_state", limit: 255, null: false
    t.boolean "due_at_overridden", default: false, null: false
    t.datetime "due_at"
    t.boolean "all_day"
    t.date "all_day_date"
    t.boolean "unlock_at_overridden", default: false, null: false
    t.datetime "unlock_at"
    t.boolean "lock_at_overridden", default: false, null: false
    t.datetime "lock_at"
    t.bigint "quiz_id"
    t.integer "quiz_version"
    t.index ["assignment_id", "set_type", "set_id"], name: "index_assignment_overrides_on_assignment_and_set", unique: true, where: "(((workflow_state)::text = 'active'::text) AND (set_id IS NOT NULL))"
    t.index ["assignment_id"], name: "index_assignment_overrides_on_assignment_id"
    t.index ["quiz_id"], name: "index_assignment_overrides_on_quiz_id"
    t.index ["set_type", "set_id"], name: "index_assignment_overrides_on_set_type_and_set_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.datetime "due_at"
    t.datetime "unlock_at"
    t.datetime "lock_at"
    t.float "points_possible"
    t.float "min_score"
    t.float "max_score"
    t.float "mastery_score"
    t.string "grading_type", limit: 255
    t.string "submission_types", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "assignment_group_id"
    t.bigint "grading_standard_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "group_category", limit: 255
    t.integer "submissions_downloads", default: 0
    t.integer "peer_review_count", default: 0
    t.datetime "peer_reviews_due_at"
    t.boolean "peer_reviews_assigned", default: false, null: false
    t.boolean "peer_reviews", default: false, null: false
    t.boolean "automatic_peer_reviews", default: false, null: false
    t.boolean "all_day", default: false, null: false
    t.date "all_day_date"
    t.boolean "could_be_locked", default: false, null: false
    t.bigint "cloned_item_id"
    t.string "context_code", limit: 255
    t.integer "position"
    t.string "migration_id", limit: 255
    t.boolean "grade_group_students_individually", default: false, null: false
    t.boolean "anonymous_peer_reviews", default: false, null: false
    t.string "time_zone_edited", limit: 255
    t.boolean "turnitin_enabled", default: false, null: false
    t.string "allowed_extensions", limit: 255
    t.text "turnitin_settings"
    t.boolean "muted", default: false, null: false
    t.bigint "group_category_id"
    t.boolean "freeze_on_copy", default: false, null: false
    t.boolean "copied", default: false, null: false
    t.boolean "only_visible_to_overrides", default: false, null: false
    t.boolean "post_to_sis", default: false, null: false
    t.string "integration_id", limit: 255
    t.text "integration_data"
    t.bigint "turnitin_id"
    t.boolean "moderated_grading", default: false, null: false
    t.datetime "grades_published_at"
    t.boolean "omit_from_final_grade", default: false, null: false
    t.boolean "vericite_enabled", default: false, null: false
    t.boolean "intra_group_peer_reviews", default: false, null: false
    t.string "lti_context_id"
    t.boolean "anonymous_instructor_annotations", default: false, null: false
    t.bigint "duplicate_of_id"
    t.boolean "anonymous_grading", default: false
    t.boolean "graders_anonymous_to_graders", default: false
    t.integer "grader_count", default: 0
    t.boolean "grader_comments_visible_to_graders", default: true
    t.bigint "grader_section_id"
    t.bigint "final_grader_id"
    t.boolean "grader_names_visible_to_final_grader", default: true
    t.datetime "duplication_started_at"
    t.datetime "importing_started_at"
    t.index ["assignment_group_id"], name: "index_assignments_on_assignment_group_id"
    t.index ["context_code"], name: "index_assignments_on_context_code"
    t.index ["context_id", "context_type"], name: "index_assignments_on_context_id_and_context_type"
    t.index ["due_at", "context_code"], name: "index_assignments_on_due_at_and_context_code"
    t.index ["duplicate_of_id"], name: "index_assignments_on_duplicate_of_id", where: "(duplicate_of_id IS NOT NULL)"
    t.index ["duplication_started_at"], name: "index_assignments_on_duplication_started_at", where: "((duplication_started_at IS NOT NULL) AND ((workflow_state)::text = 'duplicating'::text))"
    t.index ["final_grader_id"], name: "index_assignments_on_final_grader_id", where: "(final_grader_id IS NOT NULL)"
    t.index ["grader_section_id"], name: "index_assignments_on_grader_section_id", where: "(grader_section_id IS NOT NULL)"
    t.index ["grading_standard_id"], name: "index_assignments_on_grading_standard_id"
    t.index ["importing_started_at"], name: "index_assignments_on_importing_started_at", where: "((importing_started_at IS NOT NULL) AND ((workflow_state)::text = 'importing'::text))"
    t.index ["lti_context_id"], name: "index_assignments_on_lti_context_id", unique: true
    t.index ["turnitin_id"], name: "index_assignments_on_turnitin_id", unique: true, where: "(turnitin_id IS NOT NULL)"
  end

  create_table "attachment_associations", force: :cascade do |t|
    t.bigint "attachment_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.index ["attachment_id"], name: "index_attachment_associations_on_attachment_id"
    t.index ["context_id", "context_type"], name: "attachment_associations_a_id_a_type"
  end

  create_table "attachments", force: :cascade do |t|
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.bigint "size"
    t.bigint "folder_id"
    t.string "content_type", limit: 255
    t.text "filename"
    t.string "uuid", limit: 255
    t.text "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "workflow_state", limit: 255
    t.bigint "user_id"
    t.boolean "locked", default: false
    t.string "file_state", limit: 255
    t.datetime "deleted_at"
    t.integer "position"
    t.datetime "lock_at"
    t.datetime "unlock_at"
    t.boolean "could_be_locked"
    t.bigint "root_attachment_id"
    t.bigint "cloned_item_id"
    t.string "migration_id", limit: 255
    t.string "namespace", limit: 255
    t.string "media_entry_id", limit: 255
    t.string "md5", limit: 255
    t.string "encoding", limit: 255
    t.boolean "need_notify"
    t.text "upload_error_message"
    t.bigint "replacement_attachment_id"
    t.bigint "usage_rights_id"
    t.datetime "modified_at"
    t.datetime "viewed_at"
    t.string "instfs_uuid"
    t.index "folder_id, file_state, ((lower(replace(display_name, '\\'::text, '\\\\'::text)))::bytea)", name: "index_attachments_on_folder_id_and_file_state_and_display_name", where: "(folder_id IS NOT NULL)"
    t.index ["cloned_item_id"], name: "index_attachments_on_cloned_item_id"
    t.index ["context_id", "context_type", "migration_id"], name: "index_attachments_on_context_and_migration_id", where: "(migration_id IS NOT NULL)"
    t.index ["context_id", "context_type"], name: "index_attachments_on_context_id_and_context_type"
    t.index ["folder_id", "file_state", "position"], name: "index_attachments_on_folder_id_and_file_state_and_position"
    t.index ["folder_id", "position"], name: "index_attachments_on_folder_id_and_position", where: "(folder_id IS NOT NULL)"
    t.index ["instfs_uuid"], name: "index_attachments_on_instfs_uuid", where: "(instfs_uuid IS NOT NULL)"
    t.index ["md5", "namespace"], name: "index_attachments_on_md5_and_namespace"
    t.index ["namespace"], name: "index_attachments_on_namespace"
    t.index ["need_notify"], name: "index_attachments_on_need_notify", where: "need_notify"
    t.index ["replacement_attachment_id"], name: "index_attachments_on_replacement_attachment_id", where: "(replacement_attachment_id IS NOT NULL)"
    t.index ["root_attachment_id"], name: "index_attachments_on_root_attachment_id_not_null", where: "(root_attachment_id IS NOT NULL)"
    t.index ["user_id"], name: "index_attachments_on_user_id"
    t.index ["workflow_state", "updated_at"], name: "index_attachments_on_workflow_state_and_updated_at"
  end

  create_table "authentication_providers", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "auth_port"
    t.string "auth_host", limit: 255
    t.string "auth_base", limit: 255
    t.string "auth_username", limit: 255
    t.string "auth_crypted_password", limit: 255
    t.string "auth_password_salt", limit: 255
    t.string "auth_type", limit: 255
    t.string "auth_over_tls", limit: 255, default: "start_tls"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "log_in_url", limit: 255
    t.string "log_out_url", limit: 255
    t.string "identifier_format", limit: 255
    t.text "certificate_fingerprint"
    t.string "entity_id", limit: 255
    t.text "auth_filter"
    t.string "requested_authn_context", limit: 255
    t.datetime "last_timeout_failure"
    t.text "login_attribute"
    t.string "idp_entity_id", limit: 255
    t.integer "position"
    t.boolean "parent_registration", default: false, null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.boolean "jit_provisioning", default: false, null: false
    t.string "metadata_uri", limit: 255
    t.json "settings", default: {}, null: false
    t.index ["account_id"], name: "index_authentication_providers_on_account_id"
    t.index ["metadata_uri"], name: "index_authentication_providers_on_metadata_uri", where: "(metadata_uri IS NOT NULL)"
    t.index ["workflow_state"], name: "index_authentication_providers_on_workflow_state"
  end

  create_table "bookmarks_bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", limit: 255, null: false
    t.string "url", limit: 255, null: false
    t.integer "position"
    t.text "json"
    t.index ["user_id"], name: "index_bookmarks_bookmarks_on_user_id"
  end

  create_table "brand_configs", primary_key: "md5", id: :string, limit: 32, force: :cascade do |t|
    t.text "variables"
    t.boolean "share", default: false, null: false
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.text "js_overrides"
    t.text "css_overrides"
    t.text "mobile_js_overrides"
    t.text "mobile_css_overrides"
    t.string "parent_md5", limit: 255
    t.index ["share"], name: "index_brand_configs_on_share"
  end

  create_table "calendar_events", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.string "location_name", limit: 255
    t.string "location_address", limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.boolean "all_day"
    t.date "all_day_date"
    t.datetime "deleted_at"
    t.bigint "cloned_item_id"
    t.string "context_code", limit: 255
    t.string "migration_id", limit: 255
    t.string "time_zone_edited", limit: 255
    t.bigint "parent_calendar_event_id"
    t.string "effective_context_code", limit: 255
    t.integer "participants_per_appointment"
    t.boolean "override_participants_per_appointment"
    t.text "comments"
    t.string "timetable_code", limit: 255
    t.index ["context_code"], name: "index_calendar_events_on_context_code"
    t.index ["context_id", "context_type", "timetable_code"], name: "index_calendar_events_on_context_and_timetable_code", unique: true, where: "(timetable_code IS NOT NULL)"
    t.index ["context_id", "context_type"], name: "index_calendar_events_on_context_id_and_context_type"
    t.index ["effective_context_code"], name: "index_calendar_events_on_effective_context_code", where: "(effective_context_code IS NOT NULL)"
    t.index ["parent_calendar_event_id"], name: "index_calendar_events_on_parent_calendar_event_id"
    t.index ["start_at"], name: "index_calendar_events_on_start_at", where: "((workflow_state)::text <> 'deleted'::text)"
    t.index ["user_id"], name: "index_calendar_events_on_user_id"
  end

  create_table "canvadocs", force: :cascade do |t|
    t.string "document_id", limit: 255
    t.string "process_state", limit: 255
    t.bigint "attachment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_annotations"
    t.index ["attachment_id"], name: "index_canvadocs_on_attachment_id"
    t.index ["document_id"], name: "index_canvadocs_on_document_id", unique: true
  end

  create_table "canvadocs_submissions", force: :cascade do |t|
    t.bigint "canvadoc_id"
    t.bigint "crocodoc_document_id"
    t.bigint "submission_id", null: false
    t.index ["canvadoc_id"], name: "index_canvadocs_submissions_on_canvadoc_id"
    t.index ["crocodoc_document_id"], name: "index_canvadocs_submissions_on_crocodoc_document_id", where: "(crocodoc_document_id IS NOT NULL)"
    t.index ["submission_id", "canvadoc_id"], name: "unique_submissions_and_canvadocs", unique: true, where: "(canvadoc_id IS NOT NULL)"
    t.index ["submission_id", "crocodoc_document_id"], name: "unique_submissions_and_crocodocs", unique: true, where: "(crocodoc_document_id IS NOT NULL)"
    t.index ["submission_id"], name: "index_canvadocs_submissions_on_submission_id"
  end

  create_table "cloned_items", force: :cascade do |t|
    t.bigint "original_item_id"
    t.string "original_item_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collaborations", force: :cascade do |t|
    t.string "collaboration_type", limit: 255
    t.string "document_id", limit: 255
    t.bigint "user_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.string "url", limit: 255
    t.string "uuid", limit: 255
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.string "title", limit: 255, null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "deleted_at"
    t.string "context_code", limit: 255
    t.string "type", limit: 255
    t.index ["context_id", "context_type"], name: "index_collaborations_on_context_id_and_context_type"
    t.index ["user_id"], name: "index_collaborations_on_user_id"
  end

  create_table "collaborators", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "collaboration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "authorized_service_user_id", limit: 255
    t.bigint "group_id"
    t.index ["collaboration_id"], name: "index_collaborators_on_collaboration_id"
    t.index ["group_id"], name: "index_collaborators_on_group_id"
    t.index ["user_id"], name: "index_collaborators_on_user_id"
  end

  create_table "communication_channels", force: :cascade do |t|
    t.string "path", limit: 255, null: false
    t.string "path_type", limit: 255, default: "email", null: false
    t.integer "position"
    t.bigint "user_id", null: false
    t.bigint "pseudonym_id"
    t.integer "bounce_count", default: 0
    t.string "workflow_state", limit: 255, null: false
    t.string "confirmation_code", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "build_pseudonym_on_confirm"
    t.datetime "last_bounce_at"
    t.text "last_bounce_details"
    t.datetime "last_suppression_bounce_at"
    t.datetime "last_transient_bounce_at"
    t.text "last_transient_bounce_details"
    t.datetime "confirmation_code_expires_at"
    t.index "lower((path)::text), path_type", name: "index_communication_channels_on_path_and_path_type"
    t.index "user_id, lower((path)::text), path_type", name: "index_communication_channels_on_user_id_and_path_and_path_type", unique: true
    t.index ["confirmation_code"], name: "index_communication_channels_on_confirmation_code"
    t.index ["last_bounce_at"], name: "index_communication_channels_on_last_bounce_at", where: "(bounce_count > 0)"
    t.index ["pseudonym_id", "position"], name: "index_communication_channels_on_pseudonym_id_and_position"
    t.index ["user_id", "position"], name: "index_communication_channels_on_user_id_and_position"
  end

  create_table "content_exports", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "attachment_id"
    t.string "export_type", limit: 255
    t.text "settings"
    t.float "progress"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "content_migration_id"
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.index ["attachment_id"], name: "index_content_exports_on_attachment_id"
    t.index ["content_migration_id"], name: "index_content_exports_on_content_migration_id"
    t.index ["user_id"], name: "index_content_exports_on_user_id", where: "(user_id IS NOT NULL)"
  end

  create_table "content_migrations", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "user_id"
    t.string "workflow_state", limit: 255, null: false
    t.text "migration_settings"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "progress"
    t.string "context_type", limit: 255
    t.bigint "attachment_id"
    t.bigint "overview_attachment_id"
    t.bigint "exported_attachment_id"
    t.bigint "source_course_id"
    t.string "migration_type", limit: 255
    t.bigint "child_subscription_id"
    t.index ["attachment_id"], name: "index_content_migrations_on_attachment_id", where: "(attachment_id IS NOT NULL)"
    t.index ["context_id"], name: "index_content_migrations_on_context_id"
    t.index ["exported_attachment_id"], name: "index_content_migrations_on_exported_attachment_id", where: "(exported_attachment_id IS NOT NULL)"
    t.index ["overview_attachment_id"], name: "index_content_migrations_on_overview_attachment_id", where: "(overview_attachment_id IS NOT NULL)"
    t.index ["source_course_id"], name: "index_content_migrations_on_source_course_id", where: "(source_course_id IS NOT NULL)"
    t.index ["user_id"], name: "index_content_migrations_on_user_id", where: "(user_id IS NOT NULL)"
  end

  create_table "content_participation_counts", force: :cascade do |t|
    t.string "content_type", limit: 255
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.bigint "user_id"
    t.integer "unread_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_id", "context_type", "user_id", "content_type"], name: "index_content_participation_counts_uniquely", unique: true
  end

  create_table "content_participations", force: :cascade do |t|
    t.string "content_type", limit: 255, null: false
    t.bigint "content_id", null: false
    t.bigint "user_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.index ["content_id", "content_type", "user_id"], name: "index_content_participations_uniquely", unique: true
    t.index ["user_id"], name: "index_content_participations_on_user_id"
    t.index ["user_id"], name: "index_content_participations_on_user_id_unread", where: "((workflow_state)::text = 'unread'::text)"
  end

  create_table "content_tags", force: :cascade do |t|
    t.bigint "content_id"
    t.string "content_type", limit: 255
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.text "title"
    t.string "tag", limit: 255
    t.text "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "comments"
    t.string "tag_type", limit: 255, default: "default"
    t.bigint "context_module_id"
    t.integer "position"
    t.integer "indent"
    t.string "migration_id", limit: 255
    t.bigint "learning_outcome_id"
    t.string "context_code", limit: 255
    t.float "mastery_score"
    t.bigint "rubric_association_id"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.bigint "cloned_item_id"
    t.bigint "associated_asset_id"
    t.string "associated_asset_type", limit: 255
    t.boolean "new_tab"
    t.index ["associated_asset_id", "associated_asset_type"], name: "index_content_tags_on_associated_asset"
    t.index ["content_id", "content_type"], name: "index_content_tags_on_content_id_and_content_type"
    t.index ["context_id", "context_type"], name: "index_content_tags_on_context_id_and_context_type"
    t.index ["context_module_id"], name: "index_content_tags_on_context_module_id"
    t.index ["learning_outcome_id"], name: "index_content_tags_on_learning_outcome_id", where: "(learning_outcome_id IS NOT NULL)"
  end

  create_table "context_external_tool_assignment_lookups", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "context_external_tool_id", null: false
    t.index ["assignment_id"], name: "index_context_external_tool_assignment_lookups_on_assignment_id"
    t.index ["context_external_tool_id", "assignment_id"], name: "tool_to_assign", unique: true
  end

  create_table "context_external_tool_placements", force: :cascade do |t|
    t.string "placement_type", limit: 255
    t.bigint "context_external_tool_id", null: false
    t.index ["context_external_tool_id"], name: "external_tool_placements_tool_id"
    t.index ["placement_type", "context_external_tool_id"], name: "external_tool_placements_type_and_tool_id", unique: true
  end

  create_table "context_external_tools", force: :cascade do |t|
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.string "domain", limit: 255
    t.string "url", limit: 4096
    t.text "shared_secret", null: false
    t.text "consumer_key", null: false
    t.string "name", limit: 255, null: false
    t.text "description"
    t.text "settings"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "migration_id", limit: 255
    t.bigint "cloned_item_id"
    t.string "tool_id", limit: 255
    t.boolean "not_selectable"
    t.string "app_center_id", limit: 255
    t.boolean "allow_membership_service_access", default: false, null: false
    t.bigint "developer_key_id"
    t.index ["consumer_key"], name: "index_context_external_tools_on_consumer_key"
    t.index ["context_id", "context_type", "migration_id"], name: "index_external_tools_on_context_and_migration_id", where: "(migration_id IS NOT NULL)"
    t.index ["context_id", "context_type"], name: "index_context_external_tools_on_context_id_and_context_type"
    t.index ["developer_key_id"], name: "index_context_external_tools_on_developer_key_id"
    t.index ["tool_id"], name: "index_context_external_tools_on_tool_id"
  end

  create_table "context_module_progressions", force: :cascade do |t|
    t.bigint "context_module_id"
    t.bigint "user_id"
    t.text "requirements_met"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "collapsed"
    t.integer "current_position"
    t.datetime "completed_at"
    t.boolean "current"
    t.integer "lock_version", default: 0, null: false
    t.datetime "evaluated_at"
    t.text "incomplete_requirements"
    t.index ["context_module_id"], name: "index_context_module_progressions_on_context_module_id"
    t.index ["user_id", "context_module_id"], name: "index_cmp_on_user_id_and_module_id", unique: true
  end

  create_table "context_modules", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.text "name"
    t.integer "position"
    t.text "prerequisites"
    t.text "completion_requirements"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "deleted_at"
    t.datetime "unlock_at"
    t.string "migration_id", limit: 255
    t.boolean "require_sequential_progress"
    t.bigint "cloned_item_id"
    t.text "completion_events"
    t.integer "requirement_count"
    t.index ["context_id", "context_type"], name: "index_context_modules_on_context_id_and_context_type"
  end

  create_table "conversation_batches", force: :cascade do |t|
    t.string "workflow_state", limit: 255, null: false
    t.bigint "user_id", null: false
    t.text "recipient_ids"
    t.bigint "root_conversation_message_id", null: false
    t.text "conversation_message_ids"
    t.text "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.string "subject", limit: 255
    t.boolean "group"
    t.boolean "generate_user_note"
    t.index ["root_conversation_message_id"], name: "index_conversation_batches_on_root_conversation_message_id"
    t.index ["user_id", "workflow_state"], name: "index_conversation_batches_on_user_id_and_workflow_state"
  end

  create_table "conversation_message_participants", force: :cascade do |t|
    t.bigint "conversation_message_id"
    t.bigint "conversation_participant_id"
    t.text "tags"
    t.bigint "user_id"
    t.string "workflow_state", limit: 255
    t.datetime "deleted_at"
    t.index ["conversation_message_id"], name: "index_conversation_message_participants_on_message_id"
    t.index ["conversation_participant_id", "conversation_message_id"], name: "index_cmp_on_cpi_and_cmi"
    t.index ["deleted_at"], name: "index_conversation_message_participants_on_deleted_at"
    t.index ["user_id", "conversation_message_id"], name: "index_conversation_message_participants_on_uid_and_message_id", unique: true
  end

  create_table "conversation_messages", force: :cascade do |t|
    t.bigint "conversation_id"
    t.bigint "author_id"
    t.datetime "created_at"
    t.boolean "generated"
    t.text "body"
    t.text "forwarded_message_ids"
    t.string "media_comment_id", limit: 255
    t.string "media_comment_type", limit: 255
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.bigint "asset_id"
    t.string "asset_type", limit: 255
    t.text "attachment_ids"
    t.boolean "has_attachments"
    t.boolean "has_media_objects"
    t.index ["author_id"], name: "index_conversation_messages_on_author_id"
    t.index ["conversation_id", "created_at"], name: "index_conversation_messages_on_conversation_id_and_created_at"
  end

  create_table "conversation_participants", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "last_message_at"
    t.boolean "subscribed", default: true
    t.string "workflow_state", limit: 255, null: false
    t.datetime "last_authored_at"
    t.boolean "has_attachments", default: false, null: false
    t.boolean "has_media_objects", default: false, null: false
    t.integer "message_count", default: 0
    t.string "label", limit: 255
    t.text "tags"
    t.datetime "visible_last_authored_at"
    t.text "root_account_ids"
    t.string "private_hash", limit: 255
    t.datetime "updated_at"
    t.index ["conversation_id", "user_id"], name: "index_conversation_participants_on_conversation_id_and_user_id", unique: true
    t.index ["private_hash", "user_id"], name: "index_conversation_participants_on_private_hash_and_user_id", unique: true, where: "(private_hash IS NOT NULL)"
    t.index ["user_id", "last_message_at"], name: "index_conversation_participants_on_user_id_and_last_message_at"
  end

  create_table "conversations", force: :cascade do |t|
    t.string "private_hash", limit: 255
    t.boolean "has_attachments", default: false, null: false
    t.boolean "has_media_objects", default: false, null: false
    t.text "tags"
    t.text "root_account_ids"
    t.string "subject", limit: 255
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.datetime "updated_at"
    t.index ["private_hash"], name: "index_conversations_on_private_hash", unique: true
  end

  create_table "course_account_associations", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "account_id", null: false
    t.integer "depth", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "course_section_id"
    t.index ["account_id", "depth"], name: "index_course_account_associations_on_account_id_and_depth_id"
    t.index ["course_id", "course_section_id", "account_id"], name: "index_caa_on_course_id_and_section_id_and_account_id", unique: true
    t.index ["course_section_id"], name: "index_course_account_associations_on_course_section_id"
  end

  create_table "course_sections", force: :cascade do |t|
    t.string "sis_source_id", limit: 255
    t.bigint "sis_batch_id"
    t.bigint "course_id", null: false
    t.bigint "root_account_id", null: false
    t.bigint "enrollment_term_id"
    t.string "name", limit: 255, null: false
    t.boolean "default_section"
    t.boolean "accepting_enrollments"
    t.boolean "can_manually_enroll"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.boolean "restrict_enrollments_to_section_dates"
    t.bigint "nonxlist_course_id"
    t.text "stuck_sis_fields"
    t.string "integration_id", limit: 255
    t.index ["course_id"], name: "index_course_sections_on_course_id"
    t.index ["enrollment_term_id"], name: "index_course_sections_on_enrollment_term_id"
    t.index ["integration_id", "root_account_id"], name: "index_sections_on_integration_id", unique: true, where: "(integration_id IS NOT NULL)"
    t.index ["nonxlist_course_id"], name: "index_course_sections_on_nonxlist_course", where: "(nonxlist_course_id IS NOT NULL)"
    t.index ["root_account_id"], name: "index_course_sections_on_root_account_id"
    t.index ["sis_batch_id"], name: "index_course_sections_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["sis_source_id", "root_account_id"], name: "index_course_sections_on_sis_source_id_and_root_account_id", unique: true, where: "(sis_source_id IS NOT NULL)"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", limit: 255
    t.bigint "account_id", null: false
    t.string "group_weighting_scheme", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.string "uuid", limit: 255
    t.datetime "start_at"
    t.datetime "conclude_at"
    t.bigint "grading_standard_id"
    t.boolean "is_public"
    t.boolean "allow_student_wiki_edits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "show_public_context_messages"
    t.text "syllabus_body"
    t.boolean "allow_student_forum_attachments", default: false
    t.string "default_wiki_editing_roles", limit: 255
    t.bigint "wiki_id"
    t.boolean "allow_student_organized_groups", default: true
    t.string "course_code", limit: 255
    t.string "default_view", limit: 255
    t.bigint "abstract_course_id"
    t.bigint "root_account_id", null: false
    t.bigint "enrollment_term_id", null: false
    t.string "sis_source_id", limit: 255
    t.bigint "sis_batch_id"
    t.boolean "open_enrollment"
    t.bigint "storage_quota"
    t.text "tab_configuration"
    t.boolean "allow_wiki_comments"
    t.text "turnitin_comments"
    t.boolean "self_enrollment"
    t.string "license", limit: 255
    t.boolean "indexed"
    t.boolean "restrict_enrollments_to_course_dates"
    t.bigint "template_course_id"
    t.string "locale", limit: 255
    t.text "settings"
    t.bigint "replacement_course_id"
    t.text "stuck_sis_fields"
    t.text "public_description"
    t.string "self_enrollment_code", limit: 255
    t.integer "self_enrollment_limit"
    t.string "integration_id", limit: 255
    t.string "time_zone", limit: 255
    t.string "lti_context_id", limit: 255
    t.bigint "turnitin_id"
    t.boolean "show_announcements_on_home_page"
    t.integer "home_page_announcement_limit"
    t.bigint "latest_outcome_import_id"
    t.index ["abstract_course_id"], name: "index_courses_on_abstract_course_id", where: "(abstract_course_id IS NOT NULL)"
    t.index ["account_id"], name: "index_courses_on_account_id"
    t.index ["enrollment_term_id"], name: "index_courses_on_enrollment_term_id"
    t.index ["integration_id", "root_account_id"], name: "index_courses_on_integration_id", unique: true, where: "(integration_id IS NOT NULL)"
    t.index ["lti_context_id"], name: "index_courses_on_lti_context_id", unique: true
    t.index ["root_account_id"], name: "index_courses_on_root_account_id"
    t.index ["self_enrollment_code"], name: "index_courses_on_self_enrollment_code", unique: true, where: "(self_enrollment_code IS NOT NULL)"
    t.index ["sis_batch_id"], name: "index_courses_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["sis_source_id", "root_account_id"], name: "index_courses_on_sis_source_id_and_root_account_id", unique: true, where: "(sis_source_id IS NOT NULL)"
    t.index ["template_course_id"], name: "index_courses_on_template_course_id"
    t.index ["uuid"], name: "index_courses_on_uuid"
    t.index ["wiki_id"], name: "index_courses_on_wiki_id", where: "(wiki_id IS NOT NULL)"
  end

  create_table "crocodoc_documents", force: :cascade do |t|
    t.string "uuid", limit: 255
    t.string "process_state", limit: 255
    t.bigint "attachment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachment_id"], name: "index_crocodoc_documents_on_attachment_id"
    t.index ["process_state"], name: "index_crocodoc_documents_on_process_state"
    t.index ["uuid"], name: "index_crocodoc_documents_on_uuid"
  end

  create_table "custom_data", force: :cascade do |t|
    t.text "data"
    t.string "namespace", limit: 255
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "namespace"], name: "index_custom_data_on_user_id_and_namespace", unique: true
  end

  create_table "custom_gradebook_column_data", force: :cascade do |t|
    t.string "content", limit: 255, null: false
    t.bigint "user_id", null: false
    t.bigint "custom_gradebook_column_id", null: false
    t.index ["custom_gradebook_column_id", "user_id"], name: "index_custom_gradebook_column_data_unique_column_and_user", unique: true
    t.index ["user_id"], name: "index_custom_gradebook_column_data_on_user_id"
  end

  create_table "custom_gradebook_columns", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.integer "position", null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "teacher_notes", default: false, null: false
    t.boolean "read_only", default: false, null: false
    t.index ["course_id"], name: "index_custom_gradebook_columns_on_course_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.string "queue", limit: 255
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tag", limit: 255
    t.integer "max_attempts"
    t.string "strand", limit: 255
    t.boolean "next_in_strand", default: true, null: false
    t.bigint "shard_id"
    t.string "source", limit: 255
    t.integer "max_concurrent", default: 1, null: false
    t.datetime "expires_at"
    t.index ["locked_by"], name: "index_delayed_jobs_on_locked_by", where: "(locked_by IS NOT NULL)"
    t.index ["priority", "run_at"], name: "get_delayed_jobs_index", where: "((locked_at IS NULL) AND ((queue)::text = 'canvas_queue'::text) AND (next_in_strand = true))"
    t.index ["run_at", "tag"], name: "index_delayed_jobs_on_run_at_and_tag"
    t.index ["shard_id"], name: "index_delayed_jobs_on_shard_id"
    t.index ["strand", "id"], name: "index_delayed_jobs_on_strand"
    t.index ["tag"], name: "index_delayed_jobs_on_tag"
  end

  create_table "delayed_messages", force: :cascade do |t|
    t.bigint "notification_id"
    t.bigint "notification_policy_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.bigint "communication_channel_id"
    t.string "frequency", limit: 255
    t.string "workflow_state", limit: 255
    t.datetime "batched_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "send_at"
    t.text "link"
    t.text "name_of_topic"
    t.text "summary"
    t.bigint "root_account_id"
    t.index ["communication_channel_id", "root_account_id", "workflow_state", "send_at"], name: "ccid_raid_ws_sa"
    t.index ["notification_policy_id"], name: "index_delayed_messages_on_notification_policy_id"
    t.index ["send_at"], name: "by_sent_at"
    t.index ["workflow_state", "send_at"], name: "ws_sa"
  end

  create_table "delayed_notifications", force: :cascade do |t|
    t.bigint "notification_id", null: false
    t.bigint "asset_id", null: false
    t.string "asset_type", limit: 255, null: false
    t.text "recipient_keys"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "developer_key_account_bindings", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "developer_key_id", null: false
    t.string "workflow_state", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id", "developer_key_id"], name: "index_dev_key_bindings_on_account_id_and_developer_key_id", unique: true
    t.index ["developer_key_id"], name: "index_developer_key_account_bindings_on_developer_key_id"
  end

  create_table "developer_keys", force: :cascade do |t|
    t.string "api_key", limit: 255
    t.string "email", limit: 255
    t.string "user_name", limit: 255
    t.bigint "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.string "name", limit: 255
    t.string "redirect_uri", limit: 255
    t.string "icon_url", limit: 255
    t.string "sns_arn", limit: 255
    t.boolean "trusted"
    t.boolean "force_token_reuse"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.boolean "replace_tokens"
    t.boolean "auto_expire_tokens"
    t.string "redirect_uris", limit: 255, default: [], null: false, array: true
    t.text "notes"
    t.integer "access_token_count", default: 0, null: false
    t.string "vendor_code"
    t.boolean "visible", default: false, null: false
    t.text "scopes"
    t.boolean "require_scopes", default: false, null: false
    t.boolean "test_cluster_only", default: false, null: false
    t.jsonb "public_jwk"
    t.boolean "internal_service", default: false, null: false
    t.index ["vendor_code"], name: "index_developer_keys_on_vendor_code"
  end

  create_table "discussion_entries", force: :cascade do |t|
    t.text "message"
    t.bigint "discussion_topic_id"
    t.bigint "user_id"
    t.bigint "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "attachment_id"
    t.string "workflow_state", limit: 255, default: "active"
    t.datetime "deleted_at"
    t.string "migration_id", limit: 255
    t.bigint "editor_id"
    t.bigint "root_entry_id"
    t.integer "depth"
    t.integer "rating_count"
    t.integer "rating_sum"
    t.index ["discussion_topic_id", "updated_at", "created_at"], name: "index_discussion_entries_for_topic"
    t.index ["editor_id"], name: "index_discussion_entries_on_editor_id", where: "(editor_id IS NOT NULL)"
    t.index ["parent_id"], name: "index_discussion_entries_on_parent_id"
    t.index ["root_entry_id", "workflow_state", "created_at"], name: "index_discussion_entries_root_entry"
    t.index ["user_id"], name: "index_discussion_entries_on_user_id"
  end

  create_table "discussion_entry_participants", force: :cascade do |t|
    t.bigint "discussion_entry_id", null: false
    t.bigint "user_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.boolean "forced_read_state"
    t.integer "rating"
    t.index ["discussion_entry_id", "user_id"], name: "index_entry_participant_on_entry_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_discussion_entry_participants_on_user_id"
  end

  create_table "discussion_topic_materialized_views", primary_key: "discussion_topic_id", id: :bigint, default: nil, force: :cascade do |t|
    t.string "json_structure", limit: 10485760
    t.string "participants_array", limit: 10485760
    t.string "entry_ids_array", limit: 10485760
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "generation_started_at"
  end

  create_table "discussion_topic_participants", force: :cascade do |t|
    t.bigint "discussion_topic_id", null: false
    t.bigint "user_id", null: false
    t.integer "unread_entry_count", default: 0, null: false
    t.string "workflow_state", limit: 255, null: false
    t.boolean "subscribed"
    t.index ["discussion_topic_id", "user_id"], name: "index_topic_participant_on_topic_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_discussion_topic_participants_on_user_id"
  end

  create_table "discussion_topic_section_visibilities", force: :cascade do |t|
    t.bigint "discussion_topic_id", null: false
    t.bigint "course_section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", limit: 255, null: false
    t.index ["course_section_id"], name: "idx_discussion_topic_section_visibility_on_section"
    t.index ["discussion_topic_id"], name: "idx_discussion_topic_section_visibility_on_topic"
  end

  create_table "discussion_topics", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "message"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "type", limit: 255
    t.bigint "user_id"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "last_reply_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "delayed_post_at"
    t.datetime "posted_at"
    t.bigint "assignment_id"
    t.bigint "attachment_id"
    t.datetime "deleted_at"
    t.bigint "root_topic_id"
    t.boolean "could_be_locked", default: false, null: false
    t.bigint "cloned_item_id"
    t.string "context_code", limit: 255
    t.integer "position"
    t.string "migration_id", limit: 255
    t.bigint "old_assignment_id"
    t.datetime "subtopics_refreshed_at"
    t.bigint "last_assignment_id"
    t.bigint "external_feed_id"
    t.bigint "editor_id"
    t.boolean "podcast_enabled", default: false, null: false
    t.boolean "podcast_has_student_posts", default: false, null: false
    t.boolean "require_initial_post", default: false, null: false
    t.string "discussion_type", limit: 255
    t.datetime "lock_at"
    t.boolean "pinned", default: false, null: false
    t.boolean "locked", default: false, null: false
    t.bigint "group_category_id"
    t.boolean "allow_rating", default: false, null: false
    t.boolean "only_graders_can_rate", default: false, null: false
    t.boolean "sort_by_rating", default: false, null: false
    t.datetime "todo_date"
    t.boolean "is_section_specific", default: false, null: false
    t.index ["assignment_id"], name: "index_discussion_topics_on_assignment_id"
    t.index ["attachment_id"], name: "index_discussion_topics_on_attachment_id", where: "(attachment_id IS NOT NULL)"
    t.index ["context_id", "context_type", "root_topic_id"], name: "index_discussion_topics_unique_subtopic_per_context", unique: true
    t.index ["context_id", "last_reply_at"], name: "index_discussion_topics_on_context_and_last_reply_at"
    t.index ["context_id", "position"], name: "index_discussion_topics_on_context_id_and_position"
    t.index ["editor_id"], name: "index_discussion_topics_on_editor_id", where: "(editor_id IS NOT NULL)"
    t.index ["external_feed_id"], name: "index_discussion_topics_on_external_feed_id", where: "(external_feed_id IS NOT NULL)"
    t.index ["id", "type"], name: "index_discussion_topics_on_id_and_type"
    t.index ["old_assignment_id"], name: "index_discussion_topics_on_old_assignment_id", where: "(old_assignment_id IS NOT NULL)"
    t.index ["root_topic_id"], name: "index_discussion_topics_on_root_topic_id"
    t.index ["user_id"], name: "index_discussion_topics_on_user_id"
    t.index ["workflow_state"], name: "index_discussion_topics_on_workflow_state"
  end

  create_table "enrollment_dates_overrides", force: :cascade do |t|
    t.bigint "enrollment_term_id"
    t.string "enrollment_type", limit: 255
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["enrollment_term_id"], name: "index_enrollment_dates_overrides_on_enrollment_term_id"
  end

  create_table "enrollment_states", primary_key: "enrollment_id", id: :bigint, default: nil, force: :cascade do |t|
    t.string "state", limit: 255
    t.boolean "state_is_current", default: false, null: false
    t.datetime "state_started_at"
    t.datetime "state_valid_until"
    t.boolean "restricted_access", default: false, null: false
    t.boolean "access_is_current", default: false, null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["state"], name: "index_enrollment_states_on_state"
    t.index ["state_is_current", "access_is_current"], name: "index_enrollment_states_on_currents"
    t.index ["state_valid_until"], name: "index_enrollment_states_on_state_valid_until"
  end

  create_table "enrollment_terms", force: :cascade do |t|
    t.bigint "root_account_id", null: false
    t.string "name", limit: 255
    t.string "term_code", limit: 255
    t.string "sis_source_id", limit: 255
    t.bigint "sis_batch_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean "accepting_enrollments"
    t.boolean "can_manually_enroll"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.text "stuck_sis_fields"
    t.string "integration_id", limit: 255
    t.bigint "grading_period_group_id"
    t.index ["grading_period_group_id"], name: "index_enrollment_terms_on_grading_period_group_id"
    t.index ["integration_id", "root_account_id"], name: "index_terms_on_integration_id", unique: true, where: "(integration_id IS NOT NULL)"
    t.index ["root_account_id"], name: "index_enrollment_terms_on_root_account_id"
    t.index ["sis_batch_id"], name: "index_enrollment_terms_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["sis_source_id", "root_account_id"], name: "index_enrollment_terms_on_sis_source_id_and_root_account_id", unique: true, where: "(sis_source_id IS NOT NULL)"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.string "type", limit: 255, null: false
    t.string "uuid", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "associated_user_id"
    t.bigint "sis_batch_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.bigint "course_section_id", null: false
    t.bigint "root_account_id", null: false
    t.datetime "completed_at"
    t.boolean "self_enrolled"
    t.string "grade_publishing_status", limit: 255, default: "unpublished"
    t.datetime "last_publish_attempt_at"
    t.text "stuck_sis_fields"
    t.text "grade_publishing_message"
    t.boolean "limit_privileges_to_course_section", default: false, null: false
    t.datetime "last_activity_at"
    t.integer "total_activity_time"
    t.bigint "role_id", null: false
    t.datetime "graded_at"
    t.bigint "sis_pseudonym_id"
    t.datetime "last_attended_at"
    t.index ["associated_user_id"], name: "index_enrollments_on_associated_user_id", where: "(associated_user_id IS NOT NULL)"
    t.index ["course_id", "user_id"], name: "index_enrollments_on_course_id_and_user_id"
    t.index ["course_id", "workflow_state"], name: "index_enrollments_on_course_id_and_workflow_state"
    t.index ["course_section_id"], name: "index_enrollments_on_course_section_id"
    t.index ["root_account_id", "course_id"], name: "index_enrollments_on_root_account_id_and_course_id"
    t.index ["sis_batch_id"], name: "index_enrollments_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["sis_pseudonym_id"], name: "index_enrollments_on_sis_pseudonym_id"
    t.index ["user_id", "type", "role_id", "course_section_id", "associated_user_id"], name: "index_enrollments_on_user_type_role_section_associated_user", unique: true, where: "(associated_user_id IS NOT NULL)"
    t.index ["user_id", "type", "role_id", "course_section_id"], name: "index_enrollments_on_user_type_role_section", unique: true, where: "(associated_user_id IS NULL)"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
    t.index ["uuid"], name: "index_enrollments_on_uuid"
    t.index ["workflow_state"], name: "index_enrollments_on_workflow_state"
  end

  create_table "eportfolio_categories", force: :cascade do |t|
    t.bigint "eportfolio_id", null: false
    t.string "name", limit: 255
    t.integer "position"
    t.string "slug", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["eportfolio_id"], name: "index_eportfolio_categories_on_eportfolio_id"
  end

  create_table "eportfolio_entries", force: :cascade do |t|
    t.bigint "eportfolio_id", null: false
    t.bigint "eportfolio_category_id", null: false
    t.integer "position"
    t.string "name", limit: 255
    t.boolean "allow_comments"
    t.boolean "show_comments"
    t.string "slug", limit: 255
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["eportfolio_category_id"], name: "index_eportfolio_entries_on_eportfolio_category_id"
    t.index ["eportfolio_id"], name: "index_eportfolio_entries_on_eportfolio_id"
  end

  create_table "eportfolios", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", limit: 255
    t.boolean "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uuid", limit: 255
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "deleted_at"
    t.index ["user_id"], name: "index_eportfolios_on_user_id"
  end

  create_table "epub_exports", force: :cascade do |t|
    t.bigint "content_export_id"
    t.bigint "course_id"
    t.bigint "user_id"
    t.string "workflow_state", limit: 255, default: "created"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", limit: 255
    t.index ["content_export_id"], name: "index_epub_exports_on_content_export_id"
    t.index ["course_id"], name: "index_epub_exports_on_course_id"
    t.index ["user_id"], name: "index_epub_exports_on_user_id"
  end

  create_table "error_reports", force: :cascade do |t|
    t.text "backtrace"
    t.text "url"
    t.text "message"
    t.text "comments"
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", limit: 255
    t.boolean "during_tests", default: false
    t.text "user_agent"
    t.string "request_method", limit: 255
    t.text "http_env"
    t.string "subject", limit: 255
    t.string "request_context_id", limit: 255
    t.bigint "account_id"
    t.bigint "zendesk_ticket_id"
    t.text "data"
    t.string "category", limit: 255
    t.index ["category"], name: "index_error_reports_on_category"
    t.index ["created_at"], name: "error_reports_created_at"
    t.index ["zendesk_ticket_id"], name: "index_error_reports_on_zendesk_ticket_id"
  end

  create_table "event_stream_failures", force: :cascade do |t|
    t.string "operation", limit: 255, null: false
    t.string "event_stream", limit: 255, null: false
    t.string "record_id", limit: 255, null: false
    t.text "payload", null: false
    t.text "exception"
    t.text "backtrace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "external_feed_entries", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "external_feed_id", null: false
    t.text "title"
    t.text "message"
    t.string "source_name", limit: 255
    t.text "source_url"
    t.datetime "posted_at"
    t.string "workflow_state", limit: 255, null: false
    t.text "url"
    t.string "author_name", limit: 255
    t.string "author_email", limit: 255
    t.text "author_url"
    t.bigint "asset_id"
    t.string "asset_type", limit: 255
    t.string "uuid", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["external_feed_id"], name: "index_external_feed_entries_on_external_feed_id"
    t.index ["url"], name: "index_external_feed_entries_on_url"
    t.index ["user_id"], name: "index_external_feed_entries_on_user_id", where: "(user_id IS NOT NULL)"
    t.index ["uuid"], name: "index_external_feed_entries_on_uuid"
  end

  create_table "external_feeds", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.integer "consecutive_failures"
    t.integer "failures"
    t.datetime "refresh_at"
    t.string "title", limit: 255
    t.string "url", limit: 255, null: false
    t.string "header_match", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "verbosity", limit: 255
    t.string "migration_id", limit: 255
    t.index ["context_id", "context_type", "url", "header_match", "verbosity"], name: "index_external_feeds_uniquely_2", unique: true, where: "(header_match IS NOT NULL)"
    t.index ["context_id", "context_type", "url", "verbosity"], name: "index_external_feeds_uniquely_1", unique: true, where: "(header_match IS NULL)"
    t.index ["context_id", "context_type"], name: "index_external_feeds_on_context_id_and_context_type"
    t.index ["user_id"], name: "index_external_feeds_on_user_id", where: "(user_id IS NOT NULL)"
  end

  create_table "external_integration_keys", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "key_value", limit: 255, null: false
    t.string "key_type", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_id", "context_type", "key_type"], name: "index_external_integration_keys_unique", unique: true
  end

  create_table "failed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.string "handler", limit: 512000
    t.text "last_error"
    t.string "queue", limit: 255
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "tag", limit: 255
    t.integer "max_attempts"
    t.string "strand", limit: 255
    t.bigint "shard_id"
    t.bigint "original_job_id"
    t.string "source", limit: 255
    t.datetime "expires_at"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "context_id", "context_type"], name: "index_favorites_unique_user_object", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "fearless_assessments", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "quiz_id", null: false
    t.string "name"
    t.text "description"
    t.decimal "minimum"
    t.decimal "maximum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fearless_custom_contents", force: :cascade do |t|
    t.string "contentable_type", null: false
    t.integer "contentable_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contentable_type", "contentable_id"], name: "idx_custom_contents_contentable_type_contentable_id", unique: true
  end

  create_table "fearless_discussion_maps", force: :cascade do |t|
    t.string "discussion_id", null: false
    t.string "content_type", null: false
    t.integer "content_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_fearless_discussion_maps_on_discussion_id", unique: true
  end

  create_table "fearless_event_custom_data", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "time"
    t.string "description"
    t.string "thumbnail_url"
    t.string "event_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_fearless_event_custom_data_on_event_id", unique: true
  end

  create_table "fearless_learning_path_custom_data", force: :cascade do |t|
    t.integer "learning_path_id", null: false
    t.string "time"
    t.string "description"
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_path_id"], name: "index_fearless_learning_path_custom_data_on_learning_path_id", unique: true
  end

  create_table "fearless_taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_fearless_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_fearless_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_fearless_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_fearless_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_fearless_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_fearless_taggings_on_tagger_id"
  end

  create_table "fearless_tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_fearless_tags_on_name", unique: true
  end

  create_table "fearless_topic_custom_data", force: :cascade do |t|
    t.integer "topic_id", null: false
    t.string "time"
    t.string "description"
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_fearless_topic_custom_data_on_topic_id", unique: true
  end

  create_table "feature_flags", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "feature", limit: 255, null: false
    t.string "state", limit: 255, default: "allowed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_id", "context_type", "feature"], name: "index_feature_flags_on_context_and_feature", unique: true
  end

  create_table "folders", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "full_name"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "parent_folder_id"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean "locked"
    t.datetime "lock_at"
    t.datetime "unlock_at"
    t.bigint "cloned_item_id"
    t.integer "position"
    t.string "submission_context_code", limit: 255
    t.index ["cloned_item_id"], name: "index_folders_on_cloned_item_id"
    t.index ["context_id", "context_type"], name: "index_folders_on_context_id_and_context_type"
    t.index ["context_id", "context_type"], name: "index_folders_on_context_id_and_context_type_for_root_folders", unique: true, where: "((parent_folder_id IS NULL) AND ((workflow_state)::text <> 'deleted'::text))"
    t.index ["parent_folder_id"], name: "index_folders_on_parent_folder_id"
    t.index ["submission_context_code", "parent_folder_id"], name: "index_folders_on_submission_context_code_and_parent_folder_id", unique: true
  end

  create_table "gradebook_csvs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "attachment_id", null: false
    t.bigint "progress_id", null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_gradebook_csvs_on_course_id"
    t.index ["user_id", "course_id"], name: "index_gradebook_csvs_on_user_id_and_course_id"
  end

  create_table "gradebook_uploads", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.bigint "progress_id", null: false
    t.text "gradebook"
    t.index ["course_id", "user_id"], name: "index_gradebook_uploads_on_course_id_and_user_id", unique: true
    t.index ["progress_id"], name: "index_gradebook_uploads_on_progress_id"
    t.index ["user_id"], name: "index_gradebook_uploads_on_user_id"
  end

  create_table "grading_period_groups", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.string "title", limit: 255
    t.boolean "weighted"
    t.boolean "display_totals_for_all_grading_periods", default: false, null: false
    t.index ["account_id"], name: "index_grading_period_groups_on_account_id"
    t.index ["course_id"], name: "index_grading_period_groups_on_course_id"
    t.index ["workflow_state"], name: "index_grading_period_groups_on_workflow_state"
  end

  create_table "grading_periods", force: :cascade do |t|
    t.float "weight"
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", limit: 255
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.integer "grading_period_group_id", null: false
    t.datetime "close_date"
    t.index ["grading_period_group_id"], name: "index_grading_periods_on_grading_period_group_id"
    t.index ["workflow_state"], name: "index_grading_periods_on_workflow_state"
  end

  create_table "grading_standards", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "data"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.integer "usage_count"
    t.string "context_code", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.string "migration_id", limit: 255
    t.integer "version"
    t.index ["context_code"], name: "index_grading_standards_on_context_code"
    t.index ["context_id", "context_type"], name: "index_grading_standards_on_context_id_and_context_type"
    t.index ["user_id"], name: "index_grading_standards_on_user_id", where: "(user_id IS NOT NULL)"
  end

  create_table "group_categories", force: :cascade do |t|
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.string "name", limit: 255
    t.string "role", limit: 255
    t.datetime "deleted_at"
    t.string "self_signup", limit: 255
    t.integer "group_limit"
    t.string "auto_leader", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sis_source_id"
    t.bigint "root_account_id"
    t.bigint "sis_batch_id"
    t.index ["context_id", "context_type"], name: "index_group_categories_on_context"
    t.index ["role"], name: "index_group_categories_on_role"
    t.index ["root_account_id", "sis_source_id"], name: "index_group_categories_on_root_account_id_and_sis_source_id", unique: true, where: "(sis_source_id IS NOT NULL)"
    t.index ["root_account_id"], name: "index_group_categories_on_root_account_id"
    t.index ["sis_batch_id"], name: "index_group_categories_on_sis_batch_id"
  end

  create_table "group_memberships", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id", null: false
    t.string "uuid", limit: 255, null: false
    t.bigint "sis_batch_id"
    t.boolean "moderator"
    t.index ["group_id", "user_id"], name: "index_group_memberships_on_group_id_and_user_id", unique: true, where: "((workflow_state)::text <> 'deleted'::text)"
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
    t.index ["sis_batch_id"], name: "index_group_memberships_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["user_id"], name: "index_group_memberships_on_user_id"
    t.index ["uuid"], name: "index_group_memberships_on_uuid", unique: true
    t.index ["workflow_state"], name: "index_group_memberships_on_workflow_state"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "category", limit: 255
    t.integer "max_membership"
    t.boolean "is_public"
    t.bigint "account_id", null: false
    t.bigint "wiki_id"
    t.datetime "deleted_at"
    t.string "join_level", limit: 255
    t.string "default_view", limit: 255, default: "feed"
    t.string "migration_id", limit: 255
    t.bigint "storage_quota"
    t.string "uuid", limit: 255, null: false
    t.bigint "root_account_id", null: false
    t.string "sis_source_id", limit: 255
    t.bigint "sis_batch_id"
    t.text "stuck_sis_fields"
    t.bigint "group_category_id"
    t.text "description"
    t.bigint "avatar_attachment_id"
    t.bigint "leader_id"
    t.string "lti_context_id", limit: 255
    t.index ["account_id"], name: "index_groups_on_account_id"
    t.index ["context_id", "context_type"], name: "index_groups_on_context_id_and_context_type"
    t.index ["group_category_id"], name: "index_groups_on_group_category_id"
    t.index ["leader_id"], name: "index_groups_on_leader_id", where: "(leader_id IS NOT NULL)"
    t.index ["sis_batch_id"], name: "index_groups_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["sis_source_id", "root_account_id"], name: "index_groups_on_sis_source_id_and_root_account_id", unique: true, where: "(sis_source_id IS NOT NULL)"
    t.index ["uuid"], name: "index_groups_on_uuid", unique: true
    t.index ["wiki_id"], name: "index_groups_on_wiki_id", where: "(wiki_id IS NOT NULL)"
  end

  create_table "ignores", force: :cascade do |t|
    t.string "asset_type", limit: 255, null: false
    t.bigint "asset_id", null: false
    t.bigint "user_id", null: false
    t.string "purpose", limit: 255, null: false
    t.boolean "permanent", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_id", "asset_type", "user_id", "purpose"], name: "index_ignores_on_asset_and_user_id_and_purpose", unique: true
    t.index ["user_id"], name: "index_ignores_on_user_id"
  end

  create_table "late_policies", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.boolean "missing_submission_deduction_enabled", default: false, null: false
    t.decimal "missing_submission_deduction", precision: 5, scale: 2, default: "0.0", null: false
    t.boolean "late_submission_deduction_enabled", default: false, null: false
    t.decimal "late_submission_deduction", precision: 5, scale: 2, default: "0.0", null: false
    t.string "late_submission_interval", limit: 16, default: "day", null: false
    t.boolean "late_submission_minimum_percent_enabled", default: false, null: false
    t.decimal "late_submission_minimum_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_late_policies_on_course_id", unique: true
  end

  create_table "learning_outcome_groups", force: :cascade do |t|
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.string "title", limit: 255, null: false
    t.bigint "learning_outcome_group_id"
    t.bigint "root_learning_outcome_group_id"
    t.string "workflow_state", limit: 255, null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "migration_id", limit: 255
    t.string "vendor_guid", limit: 255
    t.string "low_grade", limit: 255
    t.string "high_grade", limit: 255
    t.string "vendor_guid_2", limit: 255
    t.string "migration_id_2", limit: 255
    t.bigint "outcome_import_id"
    t.index ["context_id", "context_type"], name: "index_learning_outcome_groups_on_context_id_and_context_type"
    t.index ["context_type", "context_id", "vendor_guid_2"], name: "index_learning_outcome_groups_on_context_and_vendor_guid"
    t.index ["learning_outcome_group_id"], name: "index_learning_outcome_groups_on_learning_outcome_group_id", where: "(learning_outcome_group_id IS NOT NULL)"
    t.index ["root_learning_outcome_group_id"], name: "index_learning_outcome_groups_on_root_learning_outcome_group_id", where: "(root_learning_outcome_group_id IS NOT NULL)"
    t.index ["vendor_guid"], name: "index_learning_outcome_groups_on_vendor_guid"
    t.index ["vendor_guid_2"], name: "index_learning_outcome_groups_on_vendor_guid_2"
  end

  create_table "learning_outcome_question_results", force: :cascade do |t|
    t.bigint "learning_outcome_result_id"
    t.bigint "learning_outcome_id"
    t.bigint "associated_asset_id"
    t.string "associated_asset_type", limit: 255
    t.float "score"
    t.float "possible"
    t.boolean "mastery"
    t.float "percent"
    t.integer "attempt"
    t.text "title"
    t.float "original_score"
    t.float "original_possible"
    t.boolean "original_mastery"
    t.datetime "assessed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "submitted_at"
    t.index ["learning_outcome_id"], name: "index_learning_outcome_question_results_on_learning_outcome_id"
    t.index ["learning_outcome_result_id"], name: "index_LOQR_on_learning_outcome_result_id"
  end

  create_table "learning_outcome_results", force: :cascade do |t|
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.string "context_code", limit: 255
    t.bigint "association_id"
    t.string "association_type", limit: 255
    t.bigint "content_tag_id"
    t.bigint "learning_outcome_id"
    t.boolean "mastery"
    t.bigint "user_id"
    t.float "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "attempt"
    t.float "possible"
    t.float "original_score"
    t.float "original_possible"
    t.boolean "original_mastery"
    t.bigint "artifact_id"
    t.string "artifact_type", limit: 255
    t.datetime "assessed_at"
    t.string "title", limit: 255
    t.float "percent"
    t.bigint "associated_asset_id"
    t.string "associated_asset_type", limit: 255
    t.datetime "submitted_at"
    t.boolean "hide_points", default: false, null: false
    t.boolean "hidden", default: false, null: false
    t.index ["content_tag_id"], name: "index_learning_outcome_results_on_content_tag_id"
    t.index ["learning_outcome_id"], name: "index_learning_outcome_results_on_learning_outcome_id", where: "(learning_outcome_id IS NOT NULL)"
    t.index ["user_id", "content_tag_id", "association_id", "association_type", "associated_asset_id", "associated_asset_type"], name: "index_learning_outcome_results_association", unique: true
  end

  create_table "learning_outcomes", force: :cascade do |t|
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.string "short_description", limit: 255, null: false
    t.string "context_code", limit: 255
    t.text "description"
    t.text "data"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "migration_id", limit: 255
    t.string "vendor_guid", limit: 255
    t.string "low_grade", limit: 255
    t.string "high_grade", limit: 255
    t.string "display_name", limit: 255
    t.string "calculation_method", limit: 255
    t.integer "calculation_int", limit: 2
    t.string "vendor_guid_2", limit: 255
    t.string "migration_id_2", limit: 255
    t.bigint "outcome_import_id"
    t.index ["context_id", "context_type"], name: "index_learning_outcomes_on_context_id_and_context_type"
    t.index ["vendor_guid"], name: "index_learning_outcomes_on_vendor_guid"
    t.index ["vendor_guid_2"], name: "index_learning_outcomes_on_vendor_guid_2"
  end

  create_table "live_assessments_assessments", force: :cascade do |t|
    t.string "key", limit: 255, null: false
    t.string "title", limit: 255, null: false
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_id", "context_type", "key"], name: "index_live_assessments", unique: true
  end

  create_table "live_assessments_results", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "assessor_id", null: false
    t.bigint "assessment_id", null: false
    t.boolean "passed", null: false
    t.datetime "assessed_at", null: false
    t.index ["assessment_id", "user_id"], name: "index_live_assessments_results_on_assessment_id_and_user_id"
    t.index ["user_id"], name: "index_live_assessments_results_on_user_id"
  end

  create_table "live_assessments_submissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "assessment_id", null: false
    t.float "possible"
    t.float "score"
    t.datetime "assessed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id", "user_id"], name: "index_live_assessments_submissions_on_assessment_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_live_assessments_submissions_on_user_id"
  end

  create_table "lti_line_items", force: :cascade do |t|
    t.float "score_maximum", null: false
    t.string "label", null: false
    t.string "resource_id"
    t.string "tag"
    t.bigint "lti_resource_link_id"
    t.bigint "assignment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_lti_line_items_on_assignment_id"
    t.index ["lti_resource_link_id"], name: "index_lti_line_items_on_lti_resource_link_id"
    t.index ["resource_id"], name: "index_lti_line_items_on_resource_id"
    t.index ["tag"], name: "index_lti_line_items_on_tag"
  end

  create_table "lti_links", force: :cascade do |t|
    t.string "resource_link_id", null: false
    t.string "vendor_code", null: false
    t.string "product_code", null: false
    t.string "resource_type_code", null: false
    t.bigint "linkable_id"
    t.string "linkable_type"
    t.text "custom_parameters"
    t.text "resource_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linkable_id", "linkable_type"], name: "index_lti_links_on_linkable_id_and_linkable_type"
    t.index ["resource_link_id"], name: "index_lti_links_on_resource_link_id", unique: true
  end

  create_table "lti_message_handlers", force: :cascade do |t|
    t.string "message_type", limit: 255, null: false
    t.string "launch_path", limit: 255, null: false
    t.text "capabilities"
    t.text "parameters"
    t.bigint "resource_handler_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tool_proxy_id"
    t.index ["resource_handler_id", "message_type"], name: "index_lti_message_handlers_on_resource_handler_and_type", unique: true
    t.index ["tool_proxy_id"], name: "index_lti_message_handlers_on_tool_proxy_id"
  end

  create_table "lti_product_families", force: :cascade do |t|
    t.string "vendor_code", limit: 255, null: false
    t.string "product_code", limit: 255, null: false
    t.string "vendor_name", limit: 255, null: false
    t.text "vendor_description"
    t.string "website", limit: 255
    t.string "vendor_email", limit: 255
    t.bigint "root_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "developer_key_id"
    t.index ["developer_key_id"], name: "index_lti_product_families_on_developer_key_id"
    t.index ["product_code", "vendor_code", "root_account_id", "developer_key_id"], name: "product_family_uniqueness", unique: true
  end

  create_table "lti_resource_handlers", force: :cascade do |t|
    t.string "resource_type_code", limit: 255, null: false
    t.string "placements", limit: 255
    t.string "name", limit: 255, null: false
    t.text "description"
    t.text "icon_info"
    t.bigint "tool_proxy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tool_proxy_id", "resource_type_code"], name: "index_lti_resource_handlers_on_tool_proxy_and_type_code", unique: true
  end

  create_table "lti_resource_links", force: :cascade do |t|
    t.string "resource_link_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_link_id"], name: "index_lti_resource_links_on_resource_link_id", unique: true
  end

  create_table "lti_resource_placements", force: :cascade do |t|
    t.string "placement", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "message_handler_id"
    t.index ["placement", "message_handler_id"], name: "index_resource_placements_on_placement_and_message_handler", unique: true, where: "(message_handler_id IS NOT NULL)"
  end

  create_table "lti_results", force: :cascade do |t|
    t.float "result_score"
    t.float "result_maximum"
    t.text "comment"
    t.string "activity_progress"
    t.string "grading_progress"
    t.bigint "lti_line_item_id", null: false
    t.bigint "submission_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lti_line_item_id", "user_id"], name: "index_lti_results_on_lti_line_item_id_and_user_id", unique: true
    t.index ["lti_line_item_id"], name: "index_lti_results_on_lti_line_item_id"
    t.index ["submission_id"], name: "index_lti_results_on_submission_id"
    t.index ["user_id"], name: "index_lti_results_on_user_id"
  end

  create_table "lti_tool_configurations", force: :cascade do |t|
    t.bigint "developer_key_id", null: false
    t.jsonb "settings", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "disabled_placements", default: [], array: true
    t.text "custom_fields"
    t.index ["developer_key_id"], name: "index_lti_tool_configurations_on_developer_key_id", unique: true
  end

  create_table "lti_tool_consumer_profiles", force: :cascade do |t|
    t.text "services"
    t.text "capabilities"
    t.string "uuid", null: false
    t.bigint "developer_key_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_key_id"], name: "index_lti_tool_consumer_profiles_on_developer_key_id", unique: true
    t.index ["uuid"], name: "index_lti_tool_consumer_profiles_on_uuid", unique: true
  end

  create_table "lti_tool_proxies", force: :cascade do |t|
    t.text "shared_secret", null: false
    t.string "guid", limit: 255, null: false
    t.string "product_version", limit: 255, null: false
    t.string "lti_version", limit: 255, null: false
    t.bigint "product_family_id", null: false
    t.bigint "context_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.text "raw_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "context_type", limit: 255, default: "Account", null: false
    t.string "name", limit: 255
    t.text "description"
    t.text "update_payload"
    t.text "registration_url"
    t.index ["guid"], name: "index_lti_tool_proxies_on_guid"
  end

  create_table "lti_tool_proxy_bindings", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "tool_proxy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled", default: true, null: false
    t.index ["context_id", "context_type", "tool_proxy_id"], name: "index_lti_tool_proxy_bindings_on_context_and_tool_proxy", unique: true
  end

  create_table "lti_tool_settings", force: :cascade do |t|
    t.bigint "tool_proxy_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.text "resource_link_id"
    t.text "custom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_code"
    t.string "vendor_code"
    t.string "resource_type_code"
    t.text "custom_parameters"
    t.text "resource_url"
    t.index ["resource_link_id", "context_type", "context_id", "tool_proxy_id"], name: "index_lti_tool_settings_on_link_context_and_tool_proxy", unique: true
  end

  create_table "master_courses_child_content_tags", force: :cascade do |t|
    t.bigint "child_subscription_id", null: false
    t.string "content_type", limit: 255, null: false
    t.bigint "content_id", null: false
    t.text "downstream_changes"
    t.string "migration_id"
    t.index ["child_subscription_id"], name: "index_child_content_tags_on_subscription"
    t.index ["content_type", "content_id"], name: "index_child_content_tags_on_content", unique: true
    t.index ["migration_id"], name: "index_child_content_tags_on_migration_id"
  end

  create_table "master_courses_child_subscriptions", force: :cascade do |t|
    t.bigint "master_template_id", null: false
    t.bigint "child_course_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.boolean "use_selective_copy", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_course_id"], name: "index_child_subscriptions_on_child_course_id"
    t.index ["master_template_id", "child_course_id"], name: "index_mc_child_subscriptions_on_template_id_and_course_id", unique: true, where: "((workflow_state)::text <> 'deleted'::text)"
    t.index ["master_template_id"], name: "index_master_courses_child_subscriptions_on_master_template_id"
  end

  create_table "master_courses_master_content_tags", force: :cascade do |t|
    t.bigint "master_template_id", null: false
    t.string "content_type", limit: 255, null: false
    t.bigint "content_id", null: false
    t.bigint "current_migration_id"
    t.text "restrictions"
    t.string "migration_id"
    t.boolean "use_default_restrictions", default: false, null: false
    t.index ["master_template_id", "content_type", "content_id"], name: "index_master_content_tags_on_template_id_and_content", unique: true
    t.index ["master_template_id"], name: "index_master_courses_master_content_tags_on_master_template_id"
    t.index ["migration_id"], name: "index_master_content_tags_on_migration_id", unique: true
  end

  create_table "master_courses_master_migrations", force: :cascade do |t|
    t.bigint "master_template_id", null: false
    t.bigint "user_id"
    t.text "export_results"
    t.datetime "exports_started_at"
    t.datetime "imports_queued_at"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "imports_completed_at"
    t.text "comment"
    t.boolean "send_notification", default: false, null: false
    t.text "migration_settings"
    t.index ["master_template_id"], name: "index_master_courses_master_migrations_on_master_template_id"
  end

  create_table "master_courses_master_templates", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.boolean "full_course", default: true, null: false
    t.string "workflow_state", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "active_migration_id"
    t.text "default_restrictions"
    t.boolean "use_default_restrictions_by_type", default: false, null: false
    t.text "default_restrictions_by_type"
    t.index ["course_id"], name: "index_master_courses_master_templates_on_course_id"
    t.index ["course_id"], name: "index_master_templates_unique_on_course_and_full", unique: true, where: "(full_course AND ((workflow_state)::text <> 'deleted'::text))"
  end

  create_table "master_courses_migration_results", force: :cascade do |t|
    t.bigint "master_migration_id", null: false
    t.bigint "content_migration_id", null: false
    t.bigint "child_subscription_id", null: false
    t.string "import_type", null: false
    t.string "state", null: false
    t.text "results"
    t.index ["master_migration_id", "content_migration_id"], name: "index_mc_migration_results_on_master_and_content_migration_ids", unique: true
    t.index ["master_migration_id", "state"], name: "index_mc_migration_results_on_master_mig_id_and_state"
  end

  create_table "media_objects", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.string "user_type", limit: 255
    t.string "title", limit: 255
    t.string "user_entered_title", limit: 255
    t.string "media_id", limit: 255, null: false
    t.string "media_type", limit: 255
    t.integer "duration"
    t.integer "max_size"
    t.bigint "root_account_id"
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "attachment_id"
    t.integer "total_size"
    t.string "old_media_id", limit: 255
    t.index ["attachment_id"], name: "index_media_objects_on_attachment_id"
    t.index ["context_id", "context_type"], name: "index_media_objects_on_context_id_and_context_type"
    t.index ["media_id"], name: "index_media_objects_on_media_id"
    t.index ["old_media_id"], name: "index_media_objects_on_old_media_id"
    t.index ["root_account_id"], name: "index_media_objects_on_root_account_id"
    t.index ["user_id"], name: "index_media_objects_on_user_id", where: "(user_id IS NOT NULL)"
  end

  create_table "media_tracks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "media_object_id", null: false
    t.string "kind", limit: 255, default: "subtitles"
    t.string "locale", limit: 255, default: "en"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_object_id", "locale"], name: "media_object_id_locale"
  end

  create_table "messages", force: :cascade do |t|
    t.text "to"
    t.text "from"
    t.text "subject"
    t.text "body"
    t.integer "delay_for", default: 120
    t.datetime "dispatch_at"
    t.datetime "sent_at"
    t.string "workflow_state", limit: 255
    t.text "transmission_errors"
    t.boolean "is_bounced"
    t.bigint "notification_id"
    t.bigint "communication_channel_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "notification_name", limit: 255
    t.text "url"
    t.string "path_type", limit: 255
    t.text "from_name"
    t.boolean "to_email"
    t.text "html_body"
    t.bigint "root_account_id"
    t.string "reply_to_name", limit: 255
    t.index ["communication_channel_id"], name: "index_messages_on_communication_channel_id"
    t.index ["context_id", "context_type", "notification_name", "to", "user_id"], name: "existing_undispatched_message"
    t.index ["notification_id"], name: "index_messages_on_notification_id"
    t.index ["root_account_id"], name: "index_messages_on_root_account_id"
    t.index ["sent_at"], name: "index_messages_on_sent_at", where: "(sent_at IS NOT NULL)"
    t.index ["user_id", "to_email", "dispatch_at"], name: "index_messages_user_id_dispatch_at_to_email"
  end

  create_table "migration_issues", force: :cascade do |t|
    t.bigint "content_migration_id", null: false
    t.text "description"
    t.string "workflow_state", limit: 255, null: false
    t.text "fix_issue_html_url"
    t.string "issue_type", limit: 255, null: false
    t.bigint "error_report_id"
    t.text "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_migration_id"], name: "index_migration_issues_on_content_migration_id"
  end

  create_table "moderated_grading_provisional_grades", force: :cascade do |t|
    t.string "grade", limit: 255
    t.float "score"
    t.datetime "graded_at"
    t.bigint "scorer_id", null: false
    t.bigint "submission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "final", default: false, null: false
    t.bigint "source_provisional_grade_id"
    t.boolean "graded_anonymously"
    t.index ["scorer_id"], name: "index_moderated_grading_provisional_grades_on_scorer_id"
    t.index ["source_provisional_grade_id"], name: "index_provisional_grades_on_source_grade", where: "(source_provisional_grade_id IS NOT NULL)"
    t.index ["submission_id", "scorer_id"], name: "idx_mg_provisional_grades_unique_sub_scorer_when_not_final", unique: true, where: "(final = false)"
    t.index ["submission_id"], name: "idx_mg_provisional_grades_unique_submission_when_final", unique: true, where: "(final = true)"
    t.index ["submission_id"], name: "index_moderated_grading_provisional_grades_on_submission_id"
  end

  create_table "moderated_grading_selections", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "student_id", null: false
    t.bigint "selected_provisional_grade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id", "student_id"], name: "idx_mg_selections_unique_on_assignment_and_student", unique: true
    t.index ["selected_provisional_grade_id"], name: "index_moderated_grading_selections_on_selected_grade", where: "(selected_provisional_grade_id IS NOT NULL)"
    t.index ["student_id"], name: "index_moderated_grading_selections_on_student_id"
  end

  create_table "moderation_graders", force: :cascade do |t|
    t.string "anonymous_id", limit: 5, null: false
    t.bigint "assignment_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "slot_taken", default: true, null: false
    t.index ["assignment_id", "anonymous_id"], name: "index_moderation_graders_on_assignment_id_and_anonymous_id", unique: true
    t.index ["assignment_id"], name: "index_moderation_graders_on_assignment_id"
    t.index ["user_id", "assignment_id"], name: "index_moderation_graders_on_user_id_and_assignment_id", unique: true
  end

  create_table "notification_endpoints", force: :cascade do |t|
    t.bigint "access_token_id", null: false
    t.string "token", limit: 255, null: false
    t.string "arn", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", default: "active", null: false
    t.index ["access_token_id"], name: "index_notification_endpoints_on_access_token_id"
    t.index ["workflow_state"], name: "index_notification_endpoints_on_workflow_state"
  end

  create_table "notification_policies", force: :cascade do |t|
    t.bigint "notification_id"
    t.bigint "communication_channel_id", null: false
    t.string "frequency", limit: 255, default: "immediately", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["communication_channel_id", "notification_id"], name: "index_notification_policies_on_cc_and_notification_id", unique: true
    t.index ["notification_id"], name: "index_notification_policies_on_notification_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "workflow_state", limit: 255, null: false
    t.string "name", limit: 255
    t.string "subject", limit: 255
    t.string "category", limit: 255
    t.integer "delay_for", default: 120
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "main_link", limit: 255
    t.index ["name"], name: "index_notifications_unique_on_name", unique: true
  end

  create_table "oauth_requests", force: :cascade do |t|
    t.string "token", limit: 255
    t.string "secret", limit: 255
    t.string "user_secret", limit: 255
    t.string "return_url", limit: 4096
    t.string "workflow_state", limit: 255
    t.bigint "user_id"
    t.string "original_host_with_port", limit: 255
    t.string "service", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_oauth_requests_on_user_id", where: "(user_id IS NOT NULL)"
  end

  create_table "observer_alert_thresholds", force: :cascade do |t|
    t.string "alert_type", null: false
    t.string "threshold"
    t.string "workflow_state", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "observer_id", null: false
    t.index ["alert_type", "user_id", "observer_id"], name: "observer_alert_thresholds_on_alert_type_and_observer_and_user", unique: true
    t.index ["observer_id"], name: "index_observer_alert_thresholds_on_observer_id"
    t.index ["user_id"], name: "index_observer_alert_thresholds_on_user_id"
    t.index ["workflow_state"], name: "index_observer_alert_thresholds_on_workflow_state"
  end

  create_table "observer_alerts", force: :cascade do |t|
    t.bigint "observer_alert_threshold_id", null: false
    t.string "context_type"
    t.bigint "context_id"
    t.string "alert_type", null: false
    t.string "workflow_state", default: "unread", null: false
    t.datetime "action_date", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "observer_id", null: false
    t.index ["context_type", "context_id"], name: "index_observer_alerts_on_context_type_and_context_id"
    t.index ["observer_alert_threshold_id"], name: "index_observer_alerts_on_observer_alert_threshold_id"
    t.index ["observer_id"], name: "index_observer_alerts_on_observer_id"
    t.index ["user_id"], name: "index_observer_alerts_on_user_id"
    t.index ["workflow_state"], name: "index_observer_alerts_on_workflow_state"
  end

  create_table "observer_pairing_codes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "code", limit: 10, null: false
    t.datetime "expires_at", null: false
    t.string "workflow_state", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_observer_pairing_codes_on_expires_at"
    t.index ["user_id"], name: "index_observer_pairing_codes_on_user_id"
    t.index ["workflow_state"], name: "index_observer_pairing_codes_on_workflow_state"
  end

  create_table "one_time_passwords", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "code", null: false
    t.boolean "used", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "code"], name: "index_one_time_passwords_on_user_id_and_code", unique: true
  end

  create_table "originality_reports", force: :cascade do |t|
    t.bigint "attachment_id"
    t.float "originality_score"
    t.bigint "originality_report_attachment_id"
    t.text "originality_report_url"
    t.text "originality_report_lti_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "submission_id", null: false
    t.string "workflow_state", default: "pending", null: false
    t.text "link_id"
    t.index ["attachment_id"], name: "index_originality_reports_on_attachment_id"
    t.index ["originality_report_attachment_id"], name: "index_originality_reports_on_originality_report_attachment_id", unique: true
    t.index ["submission_id"], name: "index_originality_reports_on_submission_id"
    t.index ["workflow_state"], name: "index_originality_reports_on_workflow_state"
  end

  create_table "outcome_import_errors", force: :cascade do |t|
    t.bigint "outcome_import_id", null: false
    t.string "message", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row"
    t.boolean "failure", default: false, null: false
    t.index ["outcome_import_id"], name: "index_outcome_import_errors_on_outcome_import_id"
  end

  create_table "outcome_imports", force: :cascade do |t|
    t.string "workflow_state", null: false
    t.bigint "context_id", null: false
    t.string "context_type", null: false
    t.bigint "user_id"
    t.bigint "attachment_id"
    t.integer "progress"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "data"
    t.index ["attachment_id"], name: "index_outcome_imports_on_attachment_id"
    t.index ["context_type", "context_id"], name: "index_outcome_imports_on_context_type_and_context_id"
    t.index ["user_id"], name: "index_outcome_imports_on_user_id"
  end

  create_table "outcome_proficiencies", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_outcome_proficiencies_on_account_id", unique: true
  end

  create_table "outcome_proficiency_ratings", force: :cascade do |t|
    t.bigint "outcome_proficiency_id", null: false
    t.string "description", limit: 255, null: false
    t.float "points", null: false
    t.boolean "mastery", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["outcome_proficiency_id", "points"], name: "index_outcome_proficiency_ratings_on_proficiency_and_points"
    t.index ["outcome_proficiency_id"], name: "index_outcome_proficiency_ratings_on_outcome_proficiency_id"
  end

  create_table "page_comments", force: :cascade do |t|
    t.text "message"
    t.bigint "page_id"
    t.string "page_type", limit: 255
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page_id", "page_type"], name: "index_page_comments_on_page_id_and_page_type"
    t.index ["user_id"], name: "index_page_comments_on_user_id"
  end

  create_table "page_views", primary_key: "request_id", id: :string, limit: 255, force: :cascade do |t|
    t.string "session_id", limit: 255
    t.bigint "user_id", null: false
    t.text "url"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.bigint "asset_id"
    t.string "asset_type", limit: 255
    t.string "controller", limit: 255
    t.string "action", limit: 255
    t.float "interaction_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "developer_key_id"
    t.boolean "user_request"
    t.float "render_time"
    t.text "user_agent"
    t.bigint "asset_user_access_id"
    t.boolean "participated"
    t.boolean "summarized"
    t.bigint "account_id"
    t.bigint "real_user_id"
    t.string "http_method", limit: 255
    t.string "remote_ip", limit: 255
    t.index ["account_id", "created_at"], name: "index_page_views_on_account_id_and_created_at"
    t.index ["asset_user_access_id"], name: "index_page_views_asset_user_access_id"
    t.index ["context_type", "context_id"], name: "index_page_views_on_context_type_and_context_id"
    t.index ["real_user_id"], name: "index_page_views_on_real_user_id", where: "(real_user_id IS NOT NULL)"
    t.index ["summarized", "created_at"], name: "index_page_views_summarized_created_at"
    t.index ["user_id", "created_at"], name: "index_page_views_on_user_id_and_created_at"
  end

  create_table "parallel_importers", force: :cascade do |t|
    t.bigint "sis_batch_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.bigint "index", null: false
    t.bigint "batch_size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string "importer_type", limit: 255, null: false
    t.bigint "attachment_id", null: false
    t.integer "rows_processed", default: 0, null: false
    t.index ["attachment_id"], name: "index_parallel_importers_on_attachment_id"
    t.index ["sis_batch_id"], name: "index_parallel_importers_on_sis_batch_id"
  end

  create_table "planner_notes", force: :cascade do |t|
    t.datetime "todo_date", null: false
    t.string "title", null: false
    t.text "details"
    t.bigint "user_id", null: false
    t.bigint "course_id"
    t.string "workflow_state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "linked_object_type"
    t.bigint "linked_object_id"
    t.index ["user_id", "linked_object_id", "linked_object_type"], name: "index_planner_notes_on_user_id_and_linked_object", unique: true, where: "((linked_object_id IS NOT NULL) AND ((workflow_state)::text <> 'deleted'::text))"
    t.index ["user_id"], name: "index_planner_notes_on_user_id"
  end

  create_table "planner_overrides", force: :cascade do |t|
    t.string "plannable_type", null: false
    t.bigint "plannable_id", null: false
    t.bigint "user_id", null: false
    t.string "workflow_state"
    t.boolean "marked_complete", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "dismissed", default: false, null: false
    t.index ["plannable_type", "plannable_id", "user_id"], name: "index_planner_overrides_on_plannable_and_user", unique: true
    t.index ["user_id"], name: "index_planner_overrides_on_user_id"
  end

  create_table "plugin_settings", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.text "settings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "disabled"
    t.index ["name"], name: "index_plugin_settings_on_name"
  end

  create_table "polling_poll_choices", force: :cascade do |t|
    t.string "text", limit: 255
    t.boolean "is_correct", default: false, null: false
    t.bigint "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["poll_id"], name: "index_polling_poll_choices_on_poll_id"
  end

  create_table "polling_poll_sessions", force: :cascade do |t|
    t.boolean "is_published", default: false, null: false
    t.boolean "has_public_results", default: false, null: false
    t.bigint "course_id", null: false
    t.bigint "course_section_id"
    t.bigint "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_polling_poll_sessions_on_course_id"
    t.index ["course_section_id"], name: "index_polling_poll_sessions_on_course_section_id"
    t.index ["poll_id"], name: "index_polling_poll_sessions_on_poll_id"
  end

  create_table "polling_poll_submissions", force: :cascade do |t|
    t.bigint "poll_id", null: false
    t.bigint "poll_choice_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "poll_session_id", null: false
    t.index ["poll_choice_id"], name: "index_polling_poll_submissions_on_poll_choice_id"
    t.index ["poll_session_id"], name: "index_polling_poll_submissions_on_poll_session_id"
    t.index ["user_id"], name: "index_polling_poll_submissions_on_user_id"
  end

  create_table "polling_polls", force: :cascade do |t|
    t.string "question", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_polling_polls_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "root_account_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "context_id", null: false
    t.string "title", limit: 255
    t.string "path", limit: 255
    t.text "description"
    t.text "data"
    t.string "visibility", limit: 255
    t.integer "position"
    t.index ["context_type", "context_id"], name: "index_profiles_on_context_type_and_context_id", unique: true
    t.index ["root_account_id", "path"], name: "index_profiles_on_root_account_id_and_path", unique: true
  end

  create_table "progresses", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "user_id"
    t.string "tag", limit: 255, null: false
    t.float "completion"
    t.string "delayed_job_id", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "message"
    t.string "cache_key_context", limit: 255
    t.text "results"
    t.index ["context_id", "context_type"], name: "index_progresses_on_context_id_and_context_type"
  end

  create_table "pseudonyms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "account_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.string "unique_id", limit: 255, null: false
    t.string "crypted_password", limit: 255, null: false
    t.string "password_salt", limit: 255, null: false
    t.string "persistence_token", limit: 255, null: false
    t.string "single_access_token", limit: 255, null: false
    t.string "perishable_token", limit: 255, null: false
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string "last_login_ip", limit: 255
    t.string "current_login_ip", limit: 255
    t.string "reset_password_token", limit: 255, default: "", null: false
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "password_auto_generated"
    t.datetime "deleted_at"
    t.bigint "sis_batch_id"
    t.string "sis_user_id", limit: 255
    t.string "sis_ssha", limit: 255
    t.bigint "communication_channel_id"
    t.bigint "sis_communication_channel_id"
    t.text "stuck_sis_fields"
    t.string "integration_id", limit: 255
    t.bigint "authentication_provider_id"
    t.index "lower((unique_id)::text), account_id", name: "index_pseudonyms_on_unique_id_and_account_id_no_authentication_", unique: true, where: "(((workflow_state)::text = 'active'::text) AND (authentication_provider_id IS NULL))"
    t.index "lower((unique_id)::text), account_id, authentication_provider_id", name: "index_pseudonyms_on_unique_id_and_account_id_and_authentication", unique: true, where: "((workflow_state)::text = 'active'::text)"
    t.index ["account_id"], name: "index_pseudonyms_on_account_id"
    t.index ["authentication_provider_id"], name: "index_pseudonyms_on_authentication_provider_id", where: "(authentication_provider_id IS NOT NULL)"
    t.index ["integration_id", "account_id"], name: "index_pseudonyms_on_integration_id", unique: true, where: "(integration_id IS NOT NULL)"
    t.index ["persistence_token"], name: "index_pseudonyms_on_persistence_token"
    t.index ["single_access_token"], name: "index_pseudonyms_on_single_access_token"
    t.index ["sis_batch_id"], name: "index_pseudonyms_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["sis_communication_channel_id"], name: "index_pseudonyms_on_sis_communication_channel_id"
    t.index ["sis_user_id", "account_id"], name: "index_pseudonyms_on_sis_user_id_and_account_id", unique: true, where: "(sis_user_id IS NOT NULL)"
    t.index ["user_id"], name: "index_pseudonyms_on_user_id"
  end

  create_table "purgatories", force: :cascade do |t|
    t.bigint "attachment_id", null: false
    t.bigint "deleted_by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", default: "active", null: false
    t.string "old_filename", null: false
    t.string "old_display_name", limit: 255
    t.string "old_content_type", limit: 255
    t.index ["attachment_id"], name: "index_purgatories_on_attachment_id", unique: true
    t.index ["deleted_by_user_id"], name: "index_purgatories_on_deleted_by_user_id"
  end

  create_table "quiz_groups", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.string "name", limit: 255
    t.integer "pick_count"
    t.float "question_points"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "migration_id", limit: 255
    t.bigint "assessment_question_bank_id"
    t.index ["quiz_id"], name: "index_quiz_groups_on_quiz_id"
  end

  create_table "quiz_question_regrades", force: :cascade do |t|
    t.bigint "quiz_regrade_id", null: false
    t.bigint "quiz_question_id", null: false
    t.string "regrade_option", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_question_id"], name: "index_qqr_on_qq_id"
    t.index ["quiz_regrade_id", "quiz_question_id"], name: "index_qqr_on_qr_id_and_qq_id", unique: true
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.bigint "quiz_id"
    t.bigint "quiz_group_id"
    t.bigint "assessment_question_id"
    t.text "question_data"
    t.integer "assessment_question_version"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "migration_id", limit: 255
    t.string "workflow_state", limit: 255
    t.integer "duplicate_index"
    t.index ["assessment_question_id", "quiz_group_id", "duplicate_index"], name: "index_generated_quiz_questions", unique: true, where: "((assessment_question_id IS NOT NULL) AND (quiz_group_id IS NOT NULL) AND ((workflow_state)::text = 'generated'::text))"
    t.index ["assessment_question_id"], name: "index_quiz_questions_on_assessment_question_id", where: "(assessment_question_id IS NOT NULL)"
    t.index ["quiz_group_id"], name: "quiz_questions_quiz_group_id"
    t.index ["quiz_id", "assessment_question_id"], name: "idx_qqs_on_quiz_and_aq_ids"
  end

  create_table "quiz_regrade_runs", force: :cascade do |t|
    t.bigint "quiz_regrade_id", null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_regrades", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quiz_id", null: false
    t.integer "quiz_version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id", "quiz_version"], name: "index_quiz_regrades_on_quiz_id_and_quiz_version", unique: true
    t.index ["user_id"], name: "index_quiz_regrades_on_user_id"
  end

  create_table "quiz_statistics", force: :cascade do |t|
    t.bigint "quiz_id"
    t.boolean "includes_all_versions"
    t.boolean "anonymous"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "report_type", limit: 255
    t.boolean "includes_sis_ids"
    t.index ["quiz_id", "report_type"], name: "index_quiz_statistics_on_quiz_id_and_report_type"
  end

  create_table "quiz_submission_events", force: :cascade do |t|
    t.integer "attempt", null: false
    t.string "event_type", limit: 255, null: false
    t.bigint "quiz_submission_id", null: false
    t.text "event_data"
    t.datetime "created_at", null: false
    t.datetime "client_timestamp"
    t.index ["created_at"], name: "index_quiz_submission_events_on_created_at"
    t.index ["quiz_submission_id", "attempt", "created_at"], name: "event_predecessor_locator_index"
  end

  create_table "quiz_submission_events_2018_10", id: :bigint, default: -> { "nextval('quiz_submission_events_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "attempt", null: false
    t.string "event_type", limit: 255, null: false
    t.bigint "quiz_submission_id", null: false
    t.text "event_data"
    t.datetime "created_at", null: false
    t.datetime "client_timestamp"
    t.index ["created_at"], name: "quiz_submission_events_2018_10_created_at_idx"
    t.index ["quiz_submission_id", "attempt", "created_at"], name: "quiz_submission_events_2018_1_quiz_submission_id_attempt_cr_idx"
  end

  create_table "quiz_submission_events_2018_11", id: :bigint, default: -> { "nextval('quiz_submission_events_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "attempt", null: false
    t.string "event_type", limit: 255, null: false
    t.bigint "quiz_submission_id", null: false
    t.text "event_data"
    t.datetime "created_at", null: false
    t.datetime "client_timestamp"
    t.index ["created_at"], name: "quiz_submission_events_2018_11_created_at_idx"
    t.index ["quiz_submission_id", "attempt", "created_at"], name: "quiz_submission_events_2018_1_quiz_submission_id_attempt_c_idx1"
  end

  create_table "quiz_submission_events_2018_12", id: :bigint, default: -> { "nextval('quiz_submission_events_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "attempt", null: false
    t.string "event_type", limit: 255, null: false
    t.bigint "quiz_submission_id", null: false
    t.text "event_data"
    t.datetime "created_at", null: false
    t.datetime "client_timestamp"
    t.index ["created_at"], name: "quiz_submission_events_2018_12_created_at_idx"
    t.index ["quiz_submission_id", "attempt", "created_at"], name: "quiz_submission_events_2018_1_quiz_submission_id_attempt_c_idx2"
  end

  create_table "quiz_submission_snapshots", force: :cascade do |t|
    t.bigint "quiz_submission_id"
    t.integer "attempt"
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["quiz_submission_id"], name: "index_quiz_submission_snapshots_on_quiz_submission_id"
  end

  create_table "quiz_submissions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.integer "quiz_version"
    t.bigint "user_id"
    t.text "submission_data"
    t.bigint "submission_id"
    t.float "score"
    t.float "kept_score"
    t.text "quiz_data"
    t.datetime "started_at"
    t.datetime "end_at"
    t.datetime "finished_at"
    t.integer "attempt"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "fudge_points", default: 0.0
    t.float "quiz_points_possible"
    t.integer "extra_attempts"
    t.string "temporary_user_code", limit: 255
    t.integer "extra_time"
    t.boolean "manually_unlocked"
    t.boolean "manually_scored"
    t.string "validation_token", limit: 255
    t.float "score_before_regrade"
    t.boolean "was_preview"
    t.boolean "has_seen_results"
    t.boolean "question_references_fixed"
    t.index ["quiz_id", "user_id"], name: "index_quiz_submissions_on_quiz_id_and_user_id", unique: true
    t.index ["submission_id"], name: "index_quiz_submissions_on_submission_id"
    t.index ["temporary_user_code"], name: "index_quiz_submissions_on_temporary_user_code"
    t.index ["user_id"], name: "index_quiz_submissions_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.text "quiz_data"
    t.float "points_possible"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "assignment_id"
    t.string "workflow_state", limit: 255, null: false
    t.boolean "shuffle_answers", default: false, null: false
    t.boolean "show_correct_answers", default: true, null: false
    t.integer "time_limit"
    t.integer "allowed_attempts"
    t.string "scoring_policy", limit: 255
    t.string "quiz_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "lock_at"
    t.datetime "unlock_at"
    t.datetime "deleted_at"
    t.boolean "could_be_locked", default: false, null: false
    t.bigint "cloned_item_id"
    t.string "access_code", limit: 255
    t.string "migration_id", limit: 255
    t.integer "unpublished_question_count", default: 0
    t.datetime "due_at"
    t.integer "question_count"
    t.bigint "last_assignment_id"
    t.datetime "published_at"
    t.datetime "last_edited_at"
    t.boolean "anonymous_submissions", default: false, null: false
    t.bigint "assignment_group_id"
    t.string "hide_results", limit: 255
    t.string "ip_filter", limit: 255
    t.boolean "require_lockdown_browser", default: false, null: false
    t.boolean "require_lockdown_browser_for_results", default: false, null: false
    t.boolean "one_question_at_a_time", default: false, null: false
    t.boolean "cant_go_back", default: false, null: false
    t.datetime "show_correct_answers_at"
    t.datetime "hide_correct_answers_at"
    t.boolean "require_lockdown_browser_monitor", default: false, null: false
    t.text "lockdown_browser_monitor_data"
    t.boolean "only_visible_to_overrides", default: false, null: false
    t.boolean "one_time_results", default: false, null: false
    t.boolean "show_correct_answers_last_attempt", default: false, null: false
    t.index ["assignment_id"], name: "index_quizzes_on_assignment_id", unique: true
    t.index ["context_id", "context_type"], name: "index_quizzes_on_context_id_and_context_type"
  end

  create_table "report_snapshots", force: :cascade do |t|
    t.string "report_type", limit: 255
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "account_id"
    t.index ["report_type", "account_id", "created_at"], name: "index_on_report_snapshots"
  end

  create_table "role_overrides", force: :cascade do |t|
    t.string "permission", limit: 255
    t.boolean "enabled", default: true, null: false
    t.boolean "locked", default: false, null: false
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "applies_to_self", default: true, null: false
    t.boolean "applies_to_descendants", default: true, null: false
    t.bigint "role_id", null: false
    t.index ["context_id", "context_type", "role_id", "permission"], name: "index_role_overrides_on_context_role_permission", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "base_role_type", limit: 255, null: false
    t.bigint "account_id"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.bigint "root_account_id"
    t.index ["account_id", "name"], name: "index_roles_unique_account_name_where_active", unique: true, where: "((workflow_state)::text = 'active'::text)"
    t.index ["account_id"], name: "index_roles_on_account_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["root_account_id"], name: "index_roles_on_root_account_id"
  end

  create_table "rubric_assessments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "rubric_id", null: false
    t.bigint "rubric_association_id"
    t.float "score"
    t.text "data"
    t.text "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "artifact_id", null: false
    t.string "artifact_type", limit: 255, null: false
    t.string "assessment_type", limit: 255, null: false
    t.bigint "assessor_id"
    t.integer "artifact_attempt"
    t.boolean "hide_points", default: false, null: false
    t.index ["artifact_id", "artifact_type"], name: "index_rubric_assessments_on_artifact_id_and_artifact_type"
    t.index ["assessor_id"], name: "index_rubric_assessments_on_assessor_id"
    t.index ["rubric_association_id"], name: "index_rubric_assessments_on_rubric_association_id"
    t.index ["rubric_id"], name: "index_rubric_assessments_on_rubric_id"
    t.index ["user_id"], name: "index_rubric_assessments_on_user_id"
  end

  create_table "rubric_associations", force: :cascade do |t|
    t.bigint "rubric_id", null: false
    t.bigint "association_id", null: false
    t.string "association_type", limit: 255, null: false
    t.boolean "use_for_grading"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title", limit: 255
    t.text "summary_data"
    t.string "purpose", limit: 255, null: false
    t.string "url", limit: 255
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.boolean "hide_score_total"
    t.boolean "bookmarked", default: true
    t.string "context_code", limit: 255
    t.boolean "hide_points", default: false
    t.boolean "hide_outcome_results", default: false
    t.index ["association_id", "association_type"], name: "index_rubric_associations_on_aid_and_atype"
    t.index ["context_code"], name: "index_rubric_associations_on_context_code"
    t.index ["context_id", "context_type"], name: "index_rubric_associations_on_context_id_and_context_type"
    t.index ["rubric_id"], name: "index_rubric_associations_on_rubric_id"
  end

  create_table "rubrics", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "rubric_id"
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.text "data"
    t.float "points_possible"
    t.string "title", limit: 255
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "reusable", default: false
    t.boolean "public", default: false
    t.boolean "read_only", default: false
    t.integer "association_count", default: 0
    t.boolean "free_form_criterion_comments"
    t.string "context_code", limit: 255
    t.string "migration_id", limit: 255
    t.boolean "hide_score_total"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.index ["context_id", "context_type"], name: "index_rubrics_on_context_id_and_context_type"
    t.index ["user_id"], name: "index_rubrics_on_user_id"
  end

  create_table "score_metadata", force: :cascade do |t|
    t.bigint "score_id", null: false
    t.json "calculation_details", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", default: "active", null: false
    t.index ["score_id"], name: "index_score_metadata_on_score_id", unique: true
    t.index ["workflow_state"], name: "index_score_metadata_on_workflow_state"
  end

  create_table "score_statistics", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.float "minimum", null: false
    t.float "maximum", null: false
    t.float "mean", null: false
    t.integer "count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_score_statistics_on_assignment_id", unique: true
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "enrollment_id", null: false
    t.bigint "grading_period_id"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.float "current_score"
    t.float "final_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "assignment_group_id"
    t.boolean "course_score", default: false
    t.float "unposted_current_score"
    t.float "unposted_final_score"
    t.float "current_points"
    t.float "unposted_current_points"
    t.float "final_points"
    t.float "unposted_final_points"
    t.float "override_score"
    t.index ["assignment_group_id"], name: "index_scores_on_assignment_group_id"
    t.index ["enrollment_id", "assignment_group_id"], name: "index_assignment_group_scores", unique: true, where: "(assignment_group_id IS NOT NULL)"
    t.index ["enrollment_id", "grading_period_id"], name: "index_grading_period_scores", unique: true, where: "(grading_period_id IS NOT NULL)"
    t.index ["enrollment_id"], name: "index_course_scores", unique: true, where: "course_score"
    t.index ["enrollment_id"], name: "index_enrollment_scores"
  end

  create_table "session_persistence_tokens", force: :cascade do |t|
    t.string "token_salt", limit: 255, null: false
    t.string "crypted_token", limit: 255, null: false
    t.bigint "pseudonym_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pseudonym_id"], name: "index_session_persistence_tokens_on_pseudonym_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", limit: 255, null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_settings_on_name", unique: true
  end

  create_table "shared_brand_configs", force: :cascade do |t|
    t.string "name", limit: 255
    t.bigint "account_id"
    t.string "brand_config_md5", limit: 32, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_shared_brand_configs_on_account_id"
    t.index ["brand_config_md5"], name: "index_shared_brand_configs_on_brand_config_md5"
  end

  create_table "sis_batch_errors", force: :cascade do |t|
    t.bigint "sis_batch_id", null: false
    t.bigint "root_account_id", null: false
    t.text "message", null: false
    t.text "backtrace"
    t.string "file", limit: 255
    t.boolean "failure", default: false, null: false
    t.integer "row"
    t.datetime "created_at", null: false
    t.text "row_info"
    t.index ["root_account_id"], name: "index_sis_batch_errors_on_root_account_id"
    t.index ["sis_batch_id"], name: "index_sis_batch_errors_on_sis_batch_id"
  end

  create_table "sis_batch_roll_back_data", force: :cascade do |t|
    t.bigint "sis_batch_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "context_id", null: false
    t.string "previous_workflow_state", limit: 255, null: false
    t.string "updated_workflow_state", limit: 255, null: false
    t.boolean "batch_mode_delete", default: false, null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sis_batch_id"], name: "index_sis_batch_roll_back_data_on_sis_batch_id"
    t.index ["updated_workflow_state", "previous_workflow_state"], name: "index_sis_batch_roll_back_context_workflow_states"
    t.index ["workflow_state"], name: "index_sis_batch_roll_back_data_on_workflow_state"
  end

  create_table "sis_batches", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "ended_at"
    t.string "workflow_state", limit: 255, null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "attachment_id"
    t.integer "progress"
    t.text "processing_errors"
    t.text "processing_warnings"
    t.boolean "batch_mode"
    t.bigint "batch_mode_term_id"
    t.text "options"
    t.bigint "user_id"
    t.datetime "started_at"
    t.string "diffing_data_set_identifier", limit: 255
    t.boolean "diffing_remaster"
    t.bigint "generated_diff_id"
    t.bigint "errors_attachment_id"
    t.integer "change_threshold"
    t.index ["account_id", "created_at"], name: "index_sis_batches_account_id_created_at"
    t.index ["account_id", "diffing_data_set_identifier", "created_at"], name: "index_sis_batches_diffing"
    t.index ["account_id", "workflow_state", "created_at"], name: "index_sis_batches_workflow_state_for_accounts"
    t.index ["attachment_id"], name: "index_sis_batches_on_attachment_id"
    t.index ["batch_mode_term_id"], name: "index_sis_batches_on_batch_mode_term_id", where: "(batch_mode_term_id IS NOT NULL)"
    t.index ["errors_attachment_id"], name: "index_sis_batches_on_errors_attachment_id"
    t.index ["user_id"], name: "index_sis_batches_on_user_id", where: "(user_id IS NOT NULL)"
  end

  create_table "sis_post_grades_statuses", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "course_section_id"
    t.bigint "user_id"
    t.string "status", limit: 255, null: false
    t.string "message", limit: 255, null: false
    t.datetime "grades_posted_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_sis_post_grades_statuses_on_course_id"
    t.index ["course_section_id"], name: "index_sis_post_grades_statuses_on_course_section_id"
    t.index ["user_id"], name: "index_sis_post_grades_statuses_on_user_id"
  end

  create_table "stream_item_instances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stream_item_id", null: false
    t.boolean "hidden", default: false, null: false
    t.string "workflow_state", limit: 255
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.index ["context_type", "context_id"], name: "index_stream_item_instances_on_context_type_and_context_id"
    t.index ["stream_item_id", "user_id"], name: "index_stream_item_instances_on_stream_item_id_and_user_id", unique: true
    t.index ["stream_item_id"], name: "index_stream_item_instances_on_stream_item_id"
    t.index ["user_id", "hidden", "id", "stream_item_id"], name: "index_stream_item_instances_global"
  end

  create_table "stream_items", force: :cascade do |t|
    t.text "data", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.string "asset_type", limit: 255, null: false
    t.bigint "asset_id"
    t.string "notification_category", limit: 255
    t.index ["asset_type", "asset_id"], name: "index_stream_items_on_asset_type_and_asset_id", unique: true
    t.index ["updated_at"], name: "index_stream_items_on_updated_at"
  end

  create_table "submission_comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "submission_id"
    t.bigint "author_id"
    t.string "author_name", limit: 255
    t.string "group_comment_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "attachment_ids"
    t.bigint "assessment_request_id"
    t.string "media_comment_id", limit: 255
    t.string "media_comment_type", limit: 255
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.text "cached_attachments"
    t.boolean "anonymous"
    t.boolean "teacher_only_comment", default: false
    t.boolean "hidden", default: false
    t.bigint "provisional_grade_id"
    t.boolean "draft", default: false, null: false
    t.datetime "edited_at"
    t.index ["author_id"], name: "index_submission_comments_on_author_id"
    t.index ["context_id", "context_type"], name: "index_submission_comments_on_context_id_and_context_type"
    t.index ["draft"], name: "index_submission_comments_on_draft"
    t.index ["provisional_grade_id"], name: "index_submission_comments_on_provisional_grade_id", where: "(provisional_grade_id IS NOT NULL)"
    t.index ["submission_id"], name: "index_submission_comments_on_submission_id"
  end

  create_table "submission_versions", force: :cascade do |t|
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.bigint "version_id"
    t.bigint "user_id"
    t.bigint "assignment_id"
    t.index ["context_id", "version_id", "user_id", "assignment_id"], name: "index_submission_versions", unique: true, where: "((context_type)::text = 'Course'::text)"
  end

  create_table "submissions", force: :cascade do |t|
    t.text "body"
    t.string "url", limit: 255
    t.bigint "attachment_id"
    t.string "grade", limit: 255
    t.float "score"
    t.datetime "submitted_at"
    t.bigint "assignment_id", null: false
    t.bigint "user_id", null: false
    t.string "submission_type", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "group_id"
    t.text "attachment_ids"
    t.boolean "processed"
    t.integer "process_attempts", default: 0
    t.boolean "grade_matches_current_submission"
    t.float "published_score"
    t.string "published_grade", limit: 255
    t.datetime "graded_at"
    t.float "student_entered_score"
    t.bigint "grader_id"
    t.string "media_comment_id", limit: 255
    t.string "media_comment_type", limit: 255
    t.bigint "quiz_submission_id"
    t.integer "submission_comments_count"
    t.boolean "has_rubric_assessment"
    t.integer "attempt"
    t.string "context_code", limit: 255
    t.bigint "media_object_id"
    t.text "turnitin_data"
    t.boolean "has_admin_comment", default: false, null: false
    t.datetime "cached_due_date"
    t.boolean "excused"
    t.boolean "graded_anonymously"
    t.string "late_policy_status", limit: 16
    t.decimal "points_deducted", precision: 6, scale: 2
    t.bigint "grading_period_id"
    t.bigint "seconds_late_override"
    t.string "lti_user_id"
    t.string "anonymous_id", limit: 5
    t.datetime "last_comment_at"
    t.index "user_id, GREATEST(submitted_at, created_at)", name: "index_submissions_on_user_and_greatest_dates"
    t.index ["assignment_id", "anonymous_id"], name: "index_submissions_on_assignment_id_and_anonymous_id", unique: true, where: "(anonymous_id IS NOT NULL)"
    t.index ["assignment_id", "grading_period_id"], name: "index_active_submissions", where: "((workflow_state)::text <> 'deleted'::text)"
    t.index ["assignment_id", "grading_period_id"], name: "index_active_submissions_gp", where: "(((workflow_state)::text <> 'deleted'::text) AND (grading_period_id IS NOT NULL))"
    t.index ["assignment_id", "submission_type"], name: "index_submissions_on_assignment_id_and_submission_type"
    t.index ["assignment_id", "user_id"], name: "index_submissions_on_assignment_id_and_user_id"
    t.index ["assignment_id"], name: "index_submissions_needs_grading", where: "((submission_type IS NOT NULL) AND ((excused = false) OR (excused IS NULL)) AND (((workflow_state)::text = 'pending_review'::text) OR (((workflow_state)::text = ANY (ARRAY[('submitted'::character varying)::text, ('graded'::character varying)::text])) AND ((score IS NULL) OR (NOT grade_matches_current_submission)))))"
    t.index ["assignment_id"], name: "index_submissions_on_assignment_id", where: "((submission_type IS NOT NULL) AND (((workflow_state)::text = 'pending_review'::text) OR (((workflow_state)::text = 'submitted'::text) AND ((score IS NULL) OR (NOT grade_matches_current_submission)))))"
    t.index ["cached_due_date"], name: "index_submissions_on_cached_due_date"
    t.index ["graded_at"], name: "index_submissions_on_graded_at"
    t.index ["grading_period_id"], name: "index_submissions_on_grading_period_id", where: "(grading_period_id IS NOT NULL)"
    t.index ["group_id"], name: "index_submissions_on_group_id", where: "(group_id IS NOT NULL)"
    t.index ["late_policy_status"], name: "index_submissions_on_late_policy_status", where: "(((workflow_state)::text <> 'deleted'::text) AND (late_policy_status IS NOT NULL))"
    t.index ["quiz_submission_id"], name: "index_submissions_on_quiz_submission_id", where: "(quiz_submission_id IS NOT NULL)"
    t.index ["submitted_at"], name: "index_submissions_on_submitted_at"
    t.index ["user_id", "assignment_id"], name: "index_submissions_on_user_id_and_assignment_id", unique: true
    t.index ["user_id", "context_code"], name: "index_submissions_on_user_id_and_context_code"
  end

  create_table "switchman_shards", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "database_server_id", limit: 255
    t.boolean "default", default: false, null: false
    t.text "settings"
    t.bigint "delayed_jobs_shard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["default"], name: "index_switchman_shards_on_default", unique: true, where: "\"default\""
  end

  create_table "terms_of_service_contents", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "terms_updated_at", null: false
    t.string "workflow_state", null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_terms_of_service_contents_on_account_id", unique: true
  end

  create_table "terms_of_services", force: :cascade do |t|
    t.string "terms_type", default: "default", null: false
    t.boolean "passive", default: true, null: false
    t.bigint "terms_of_service_content_id"
    t.bigint "account_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "workflow_state", null: false
    t.index ["account_id"], name: "index_terms_of_services_on_account_id", unique: true
  end

  create_table "thumbnails", force: :cascade do |t|
    t.bigint "parent_id"
    t.string "content_type", limit: 255, null: false
    t.string "filename", limit: 255, null: false
    t.string "thumbnail", limit: 255
    t.integer "size", null: false
    t.integer "width"
    t.integer "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uuid", limit: 255
    t.string "namespace", limit: 255
    t.index ["parent_id", "thumbnail"], name: "index_thumbnails_size", unique: true
    t.index ["parent_id"], name: "index_thumbnails_on_parent_id"
  end

  create_table "usage_rights", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "use_justification", limit: 255, null: false
    t.string "license", limit: 255, null: false
    t.text "legal_copyright"
    t.index ["context_id", "context_type"], name: "usage_rights_context_idx"
  end

  create_table "user_account_associations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "account_id", null: false
    t.integer "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_user_account_associations_on_account_id"
    t.index ["user_id", "account_id"], name: "index_user_account_associations_on_user_id_and_account_id", unique: true
  end

  create_table "user_merge_data", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "from_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.index ["from_user_id"], name: "index_user_merge_data_on_from_user_id"
    t.index ["user_id"], name: "index_user_merge_data_on_user_id"
  end

  create_table "user_merge_data_records", force: :cascade do |t|
    t.bigint "user_merge_data_id", null: false
    t.bigint "context_id", null: false
    t.bigint "previous_user_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "previous_workflow_state", limit: 255
    t.index ["context_id", "context_type", "user_merge_data_id", "previous_user_id"], name: "index_user_merge_data_records_on_context_id_and_context_type", unique: true
    t.index ["user_merge_data_id"], name: "index_user_merge_data_records_on_user_merge_data_id"
  end

  create_table "user_notes", force: :cascade do |t|
    t.bigint "user_id"
    t.text "note"
    t.string "title", limit: 255
    t.bigint "created_by_id"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_by_id"], name: "index_user_notes_on_created_by_id"
    t.index ["user_id", "workflow_state"], name: "index_user_notes_on_user_id_and_workflow_state"
  end

  create_table "user_observers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "observer_id", null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "sis_batch_id"
    t.bigint "root_account_id"
    t.index ["observer_id"], name: "index_user_observers_on_observer_id"
    t.index ["sis_batch_id"], name: "index_user_observers_on_sis_batch_id", where: "(sis_batch_id IS NOT NULL)"
    t.index ["user_id", "observer_id", "root_account_id"], name: "index_user_observers_on_user_id_and_observer_id_and_ra", unique: true
    t.index ["workflow_state"], name: "index_user_observers_on_workflow_state"
  end

  create_table "user_profile_links", force: :cascade do |t|
    t.string "url", limit: 4096
    t.string "title", limit: 255
    t.bigint "user_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.text "bio"
    t.string "title", limit: 255
    t.bigint "user_id"
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "user_services", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "token"
    t.string "secret", limit: 255
    t.string "protocol", limit: 255
    t.string "service", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "service_user_url", limit: 255
    t.string "service_user_id", limit: 255, null: false
    t.string "service_user_name", limit: 255
    t.string "service_domain", limit: 255
    t.string "crypted_password", limit: 255
    t.string "password_salt", limit: 255
    t.string "type", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.string "last_result_id", limit: 255
    t.datetime "refresh_at"
    t.boolean "visible"
    t.index ["id", "type"], name: "index_user_services_on_id_and_type"
    t.index ["user_id"], name: "index_user_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "sortable_name", limit: 255
    t.string "workflow_state", limit: 255, null: false
    t.string "time_zone", limit: 255
    t.string "uuid", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "avatar_image_url", limit: 255
    t.string "avatar_image_source", limit: 255
    t.datetime "avatar_image_updated_at"
    t.string "phone", limit: 255
    t.string "school_name", limit: 255
    t.string "school_position", limit: 255
    t.string "short_name", limit: 255
    t.datetime "deleted_at"
    t.boolean "show_user_services", default: true
    t.string "gender", limit: 255
    t.integer "page_views_count", default: 0
    t.integer "reminder_time_for_due_dates", default: 172800
    t.integer "reminder_time_for_grading", default: 0
    t.bigint "storage_quota"
    t.string "visible_inbox_types", limit: 255
    t.datetime "last_user_note"
    t.boolean "subscribe_to_emails"
    t.text "features_used"
    t.text "preferences"
    t.string "avatar_state", limit: 255
    t.string "locale", limit: 255
    t.string "browser_locale", limit: 255
    t.integer "unread_conversations_count", default: 0
    t.text "stuck_sis_fields"
    t.boolean "public"
    t.datetime "birthdate"
    t.string "otp_secret_key_enc", limit: 255
    t.string "otp_secret_key_salt", limit: 255
    t.bigint "otp_communication_channel_id"
    t.string "initial_enrollment_type", limit: 255
    t.integer "crocodoc_id"
    t.datetime "last_logged_out"
    t.string "lti_context_id", limit: 255
    t.bigint "turnitin_id"
    t.index "((lower(replace((sortable_name)::text, '\\'::text, '\\\\'::text)))::bytea)", name: "index_users_on_sortable_name"
    t.index ["avatar_state", "avatar_image_updated_at"], name: "index_users_on_avatar_state_and_avatar_image_updated_at"
    t.index ["lti_context_id"], name: "index_users_on_lti_context_id", unique: true
    t.index ["turnitin_id"], name: "index_users_on_turnitin_id", unique: true, where: "(turnitin_id IS NOT NULL)"
    t.index ["uuid"], name: "index_users_on_uuid"
    t.index ["workflow_state"], name: "index_users_on_workflow_state"
  end

  create_table "versions", force: :cascade do |t|
    t.bigint "versionable_id"
    t.string "versionable_type", limit: 255
    t.integer "number"
    t.text "yaml"
    t.datetime "created_at"
    t.index ["versionable_id", "versionable_type", "number"], name: "index_versions_on_versionable_object_and_number", unique: true
  end

  create_table "versions_0", id: :bigint, default: -> { "nextval('versions_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "versionable_id"
    t.string "versionable_type", limit: 255
    t.integer "number"
    t.text "yaml"
    t.datetime "created_at"
    t.index ["versionable_id", "versionable_type"], name: "versions_0_versionable_id_versionable_type_idx"
  end

  create_table "versions_1", id: :bigint, default: -> { "nextval('versions_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "versionable_id"
    t.string "versionable_type", limit: 255
    t.integer "number"
    t.text "yaml"
    t.datetime "created_at"
    t.index ["versionable_id", "versionable_type"], name: "versions_1_versionable_id_versionable_type_idx"
  end

  create_table "web_conference_participants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "web_conference_id"
    t.string "participation_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_web_conference_participants_on_user_id"
    t.index ["web_conference_id"], name: "index_web_conference_participants_on_web_conference_id"
  end

  create_table "web_conferences", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "conference_type", limit: 255, null: false
    t.string "conference_key", limit: 255
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "user_ids", limit: 255
    t.string "added_user_ids", limit: 255
    t.bigint "user_id", null: false
    t.datetime "started_at"
    t.text "description"
    t.float "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uuid", limit: 255
    t.string "invited_user_ids", limit: 255
    t.datetime "ended_at"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "context_code", limit: 255
    t.string "type", limit: 255
    t.text "settings"
    t.boolean "recording_ready"
    t.index ["context_id", "context_type"], name: "index_web_conferences_on_context_id_and_context_type"
    t.index ["user_id"], name: "index_web_conferences_on_user_id"
  end

  create_table "wiki_pages", force: :cascade do |t|
    t.bigint "wiki_id", null: false
    t.string "title", limit: 255
    t.text "body"
    t.string "workflow_state", limit: 255, null: false
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "url"
    t.boolean "protected_editing", default: false
    t.string "editing_roles", limit: 255
    t.integer "view_count", default: 0
    t.datetime "revised_at"
    t.boolean "could_be_locked"
    t.bigint "cloned_item_id"
    t.string "migration_id", limit: 255
    t.bigint "assignment_id"
    t.bigint "old_assignment_id"
    t.datetime "todo_date"
    t.bigint "context_id", null: false
    t.string "context_type", null: false
    t.index ["assignment_id"], name: "index_wiki_pages_on_assignment_id"
    t.index ["context_id", "context_type"], name: "index_wiki_pages_on_context_id_and_context_type"
    t.index ["old_assignment_id"], name: "index_wiki_pages_on_old_assignment_id"
    t.index ["user_id"], name: "index_wiki_pages_on_user_id"
    t.index ["wiki_id"], name: "index_wiki_pages_on_wiki_id"
  end

  create_table "wikis", force: :cascade do |t|
    t.string "title", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "front_page_url"
    t.boolean "has_no_front_page"
  end

  add_foreign_key "abstract_courses", "accounts"
  add_foreign_key "abstract_courses", "accounts", column: "root_account_id"
  add_foreign_key "abstract_courses", "enrollment_terms"
  add_foreign_key "abstract_courses", "sis_batches"
  add_foreign_key "access_tokens", "users"
  add_foreign_key "account_notification_roles", "account_notifications"
  add_foreign_key "account_notification_roles", "roles"
  add_foreign_key "account_notifications", "accounts"
  add_foreign_key "account_notifications", "users"
  add_foreign_key "account_report_rows", "account_report_runners"
  add_foreign_key "account_report_rows", "account_reports"
  add_foreign_key "account_report_runners", "account_reports"
  add_foreign_key "account_reports", "accounts"
  add_foreign_key "account_reports", "attachments"
  add_foreign_key "account_reports", "users"
  add_foreign_key "account_users", "accounts"
  add_foreign_key "account_users", "roles"
  add_foreign_key "account_users", "users"
  add_foreign_key "accounts", "accounts", column: "parent_account_id"
  add_foreign_key "accounts", "accounts", column: "root_account_id"
  add_foreign_key "accounts", "brand_configs", column: "brand_config_md5", primary_key: "md5"
  add_foreign_key "accounts", "outcome_imports", column: "latest_outcome_import_id"
  add_foreign_key "accounts", "sis_batches"
  add_foreign_key "alert_criteria", "alerts"
  add_foreign_key "anonymous_or_moderation_events", "assignments"
  add_foreign_key "anonymous_or_moderation_events", "canvadocs"
  add_foreign_key "anonymous_or_moderation_events", "submissions"
  add_foreign_key "anonymous_or_moderation_events", "users"
  add_foreign_key "assessment_requests", "rubric_associations"
  add_foreign_key "assessment_requests", "submissions", column: "asset_id"
  add_foreign_key "assessment_requests", "users"
  add_foreign_key "assessment_requests", "users", column: "assessor_id"
  add_foreign_key "assignment_configuration_tool_lookups", "assignments"
  add_foreign_key "assignment_groups", "cloned_items"
  add_foreign_key "assignment_override_students", "assignment_overrides"
  add_foreign_key "assignment_override_students", "assignments"
  add_foreign_key "assignment_override_students", "quizzes"
  add_foreign_key "assignment_override_students", "users"
  add_foreign_key "assignment_overrides", "assignments"
  add_foreign_key "assignment_overrides", "quizzes"
  add_foreign_key "assignments", "assignments", column: "duplicate_of_id"
  add_foreign_key "assignments", "cloned_items"
  add_foreign_key "assignments", "course_sections", column: "grader_section_id"
  add_foreign_key "assignments", "group_categories"
  add_foreign_key "assignments", "users", column: "final_grader_id"
  add_foreign_key "attachments", "attachments", column: "replacement_attachment_id"
  add_foreign_key "attachments", "attachments", column: "root_attachment_id"
  add_foreign_key "attachments", "usage_rights", column: "usage_rights_id"
  add_foreign_key "authentication_providers", "accounts"
  add_foreign_key "bookmarks_bookmarks", "users"
  add_foreign_key "calendar_events", "calendar_events", column: "parent_calendar_event_id"
  add_foreign_key "calendar_events", "cloned_items"
  add_foreign_key "calendar_events", "users"
  add_foreign_key "canvadocs", "attachments"
  add_foreign_key "collaborations", "users"
  add_foreign_key "collaborators", "collaborations"
  add_foreign_key "collaborators", "groups"
  add_foreign_key "collaborators", "users"
  add_foreign_key "communication_channels", "users"
  add_foreign_key "content_exports", "attachments"
  add_foreign_key "content_exports", "content_migrations"
  add_foreign_key "content_exports", "users"
  add_foreign_key "content_migrations", "attachments"
  add_foreign_key "content_migrations", "attachments", column: "exported_attachment_id"
  add_foreign_key "content_migrations", "attachments", column: "overview_attachment_id"
  add_foreign_key "content_migrations", "courses", column: "source_course_id"
  add_foreign_key "content_migrations", "master_courses_child_subscriptions", column: "child_subscription_id"
  add_foreign_key "content_migrations", "users"
  add_foreign_key "content_participations", "users"
  add_foreign_key "content_tags", "cloned_items"
  add_foreign_key "content_tags", "context_modules"
  add_foreign_key "content_tags", "learning_outcomes"
  add_foreign_key "context_external_tool_assignment_lookups", "assignments"
  add_foreign_key "context_external_tool_assignment_lookups", "context_external_tools"
  add_foreign_key "context_external_tool_placements", "context_external_tools"
  add_foreign_key "context_external_tools", "cloned_items"
  add_foreign_key "context_module_progressions", "context_modules"
  add_foreign_key "context_module_progressions", "users"
  add_foreign_key "context_modules", "cloned_items"
  add_foreign_key "conversation_batches", "conversation_messages", column: "root_conversation_message_id"
  add_foreign_key "conversation_batches", "users"
  add_foreign_key "conversation_message_participants", "conversation_messages"
  add_foreign_key "conversation_messages", "conversations"
  add_foreign_key "course_account_associations", "accounts"
  add_foreign_key "course_account_associations", "course_sections"
  add_foreign_key "course_account_associations", "courses"
  add_foreign_key "course_sections", "accounts", column: "root_account_id"
  add_foreign_key "course_sections", "courses"
  add_foreign_key "course_sections", "courses", column: "nonxlist_course_id"
  add_foreign_key "course_sections", "enrollment_terms"
  add_foreign_key "course_sections", "sis_batches"
  add_foreign_key "courses", "abstract_courses"
  add_foreign_key "courses", "accounts"
  add_foreign_key "courses", "accounts", column: "root_account_id"
  add_foreign_key "courses", "courses", column: "template_course_id"
  add_foreign_key "courses", "enrollment_terms"
  add_foreign_key "courses", "outcome_imports", column: "latest_outcome_import_id"
  add_foreign_key "courses", "sis_batches"
  add_foreign_key "courses", "wikis"
  add_foreign_key "custom_gradebook_column_data", "custom_gradebook_columns"
  add_foreign_key "custom_gradebook_column_data", "users"
  add_foreign_key "custom_gradebook_columns", "courses"
  add_foreign_key "delayed_messages", "communication_channels"
  add_foreign_key "delayed_messages", "notification_policies"
  add_foreign_key "developer_key_account_bindings", "accounts"
  add_foreign_key "discussion_entries", "discussion_entries", column: "parent_id"
  add_foreign_key "discussion_entries", "discussion_entries", column: "root_entry_id"
  add_foreign_key "discussion_entries", "discussion_topics"
  add_foreign_key "discussion_entries", "users"
  add_foreign_key "discussion_entries", "users", column: "editor_id"
  add_foreign_key "discussion_entry_participants", "discussion_entries"
  add_foreign_key "discussion_entry_participants", "users"
  add_foreign_key "discussion_topic_materialized_views", "discussion_topics"
  add_foreign_key "discussion_topic_participants", "discussion_topics"
  add_foreign_key "discussion_topic_participants", "users"
  add_foreign_key "discussion_topic_section_visibilities", "course_sections"
  add_foreign_key "discussion_topic_section_visibilities", "discussion_topics"
  add_foreign_key "discussion_topics", "assignments"
  add_foreign_key "discussion_topics", "assignments", column: "old_assignment_id"
  add_foreign_key "discussion_topics", "attachments"
  add_foreign_key "discussion_topics", "cloned_items"
  add_foreign_key "discussion_topics", "discussion_topics", column: "root_topic_id"
  add_foreign_key "discussion_topics", "external_feeds"
  add_foreign_key "discussion_topics", "group_categories"
  add_foreign_key "discussion_topics", "users"
  add_foreign_key "discussion_topics", "users", column: "editor_id"
  add_foreign_key "enrollment_dates_overrides", "enrollment_terms"
  add_foreign_key "enrollment_states", "enrollments"
  add_foreign_key "enrollment_terms", "accounts", column: "root_account_id"
  add_foreign_key "enrollment_terms", "grading_period_groups"
  add_foreign_key "enrollment_terms", "sis_batches"
  add_foreign_key "enrollments", "accounts", column: "root_account_id"
  add_foreign_key "enrollments", "course_sections"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "roles"
  add_foreign_key "enrollments", "sis_batches"
  add_foreign_key "enrollments", "users"
  add_foreign_key "enrollments", "users", column: "associated_user_id"
  add_foreign_key "eportfolio_categories", "eportfolios"
  add_foreign_key "eportfolio_entries", "eportfolio_categories"
  add_foreign_key "eportfolio_entries", "eportfolios"
  add_foreign_key "eportfolios", "users"
  add_foreign_key "epub_exports", "content_exports"
  add_foreign_key "epub_exports", "courses"
  add_foreign_key "epub_exports", "users"
  add_foreign_key "external_feed_entries", "external_feeds"
  add_foreign_key "external_feed_entries", "users"
  add_foreign_key "external_feeds", "users"
  add_foreign_key "favorites", "users"
  add_foreign_key "fearless_taggings", "fearless_tags", column: "tag_id"
  add_foreign_key "folders", "cloned_items"
  add_foreign_key "folders", "folders", column: "parent_folder_id"
  add_foreign_key "gradebook_csvs", "courses"
  add_foreign_key "gradebook_csvs", "progresses"
  add_foreign_key "gradebook_csvs", "users"
  add_foreign_key "gradebook_uploads", "courses"
  add_foreign_key "gradebook_uploads", "progresses"
  add_foreign_key "gradebook_uploads", "users"
  add_foreign_key "grading_period_groups", "accounts"
  add_foreign_key "grading_period_groups", "courses"
  add_foreign_key "grading_periods", "grading_period_groups"
  add_foreign_key "grading_standards", "users"
  add_foreign_key "group_categories", "accounts", column: "root_account_id"
  add_foreign_key "group_categories", "sis_batches"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "sis_batches"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "groups", "accounts"
  add_foreign_key "groups", "accounts", column: "root_account_id"
  add_foreign_key "groups", "group_categories"
  add_foreign_key "groups", "sis_batches"
  add_foreign_key "groups", "users", column: "leader_id"
  add_foreign_key "groups", "wikis"
  add_foreign_key "ignores", "users"
  add_foreign_key "late_policies", "courses"
  add_foreign_key "learning_outcome_groups", "learning_outcome_groups"
  add_foreign_key "learning_outcome_groups", "learning_outcome_groups", column: "root_learning_outcome_group_id"
  add_foreign_key "learning_outcome_results", "content_tags"
  add_foreign_key "learning_outcome_results", "learning_outcomes"
  add_foreign_key "learning_outcome_results", "users"
  add_foreign_key "live_assessments_results", "live_assessments_assessments", column: "assessment_id"
  add_foreign_key "live_assessments_results", "users", column: "assessor_id"
  add_foreign_key "live_assessments_submissions", "live_assessments_assessments", column: "assessment_id"
  add_foreign_key "live_assessments_submissions", "users"
  add_foreign_key "lti_line_items", "assignments"
  add_foreign_key "lti_line_items", "lti_resource_links"
  add_foreign_key "lti_message_handlers", "lti_resource_handlers", column: "resource_handler_id"
  add_foreign_key "lti_message_handlers", "lti_tool_proxies", column: "tool_proxy_id"
  add_foreign_key "lti_product_families", "accounts", column: "root_account_id"
  add_foreign_key "lti_resource_handlers", "lti_tool_proxies", column: "tool_proxy_id"
  add_foreign_key "lti_resource_placements", "lti_message_handlers", column: "message_handler_id"
  add_foreign_key "lti_results", "lti_line_items"
  add_foreign_key "lti_results", "submissions"
  add_foreign_key "lti_results", "users"
  add_foreign_key "lti_tool_configurations", "developer_keys"
  add_foreign_key "lti_tool_consumer_profiles", "developer_keys"
  add_foreign_key "lti_tool_proxies", "lti_product_families", column: "product_family_id"
  add_foreign_key "lti_tool_proxy_bindings", "lti_tool_proxies", column: "tool_proxy_id"
  add_foreign_key "master_courses_child_content_tags", "master_courses_child_subscriptions", column: "child_subscription_id"
  add_foreign_key "master_courses_child_subscriptions", "courses", column: "child_course_id"
  add_foreign_key "master_courses_child_subscriptions", "master_courses_master_templates", column: "master_template_id"
  add_foreign_key "master_courses_master_content_tags", "master_courses_master_migrations", column: "current_migration_id"
  add_foreign_key "master_courses_master_content_tags", "master_courses_master_templates", column: "master_template_id"
  add_foreign_key "master_courses_master_migrations", "master_courses_master_templates", column: "master_template_id"
  add_foreign_key "master_courses_master_templates", "courses"
  add_foreign_key "master_courses_master_templates", "master_courses_master_migrations", column: "active_migration_id"
  add_foreign_key "master_courses_migration_results", "content_migrations"
  add_foreign_key "master_courses_migration_results", "master_courses_child_subscriptions", column: "child_subscription_id"
  add_foreign_key "master_courses_migration_results", "master_courses_master_migrations", column: "master_migration_id"
  add_foreign_key "media_objects", "accounts", column: "root_account_id"
  add_foreign_key "media_objects", "users"
  add_foreign_key "migration_issues", "content_migrations"
  add_foreign_key "moderated_grading_provisional_grades", "moderated_grading_provisional_grades", column: "source_provisional_grade_id", name: "provisional_grades_source_provisional_grade_fk"
  add_foreign_key "moderated_grading_provisional_grades", "submissions"
  add_foreign_key "moderated_grading_provisional_grades", "users", column: "scorer_id"
  add_foreign_key "moderated_grading_selections", "assignments"
  add_foreign_key "moderated_grading_selections", "moderated_grading_provisional_grades", column: "selected_provisional_grade_id"
  add_foreign_key "moderated_grading_selections", "users", column: "student_id"
  add_foreign_key "moderation_graders", "assignments"
  add_foreign_key "moderation_graders", "users"
  add_foreign_key "notification_endpoints", "access_tokens"
  add_foreign_key "notification_policies", "communication_channels"
  add_foreign_key "oauth_requests", "users"
  add_foreign_key "observer_alert_thresholds", "users"
  add_foreign_key "observer_alert_thresholds", "users", column: "observer_id"
  add_foreign_key "observer_alerts", "observer_alert_thresholds"
  add_foreign_key "observer_alerts", "users"
  add_foreign_key "observer_alerts", "users", column: "observer_id"
  add_foreign_key "observer_pairing_codes", "users"
  add_foreign_key "one_time_passwords", "users"
  add_foreign_key "originality_reports", "submissions"
  add_foreign_key "outcome_import_errors", "outcome_imports"
  add_foreign_key "outcome_imports", "attachments"
  add_foreign_key "outcome_imports", "users"
  add_foreign_key "outcome_proficiencies", "accounts"
  add_foreign_key "outcome_proficiency_ratings", "outcome_proficiencies"
  add_foreign_key "page_comments", "users"
  add_foreign_key "page_views", "users"
  add_foreign_key "page_views", "users", column: "real_user_id"
  add_foreign_key "parallel_importers", "attachments"
  add_foreign_key "parallel_importers", "sis_batches"
  add_foreign_key "planner_notes", "users"
  add_foreign_key "planner_overrides", "users"
  add_foreign_key "polling_poll_choices", "polling_polls", column: "poll_id"
  add_foreign_key "polling_poll_sessions", "course_sections"
  add_foreign_key "polling_poll_sessions", "courses"
  add_foreign_key "polling_poll_submissions", "polling_poll_choices", column: "poll_choice_id"
  add_foreign_key "polling_poll_submissions", "polling_poll_sessions", column: "poll_session_id"
  add_foreign_key "polling_poll_submissions", "polling_polls", column: "poll_id"
  add_foreign_key "polling_poll_submissions", "users"
  add_foreign_key "polling_polls", "users"
  add_foreign_key "profiles", "accounts", column: "root_account_id"
  add_foreign_key "pseudonyms", "accounts"
  add_foreign_key "pseudonyms", "authentication_providers"
  add_foreign_key "pseudonyms", "sis_batches"
  add_foreign_key "pseudonyms", "users"
  add_foreign_key "purgatories", "attachments"
  add_foreign_key "purgatories", "users", column: "deleted_by_user_id"
  add_foreign_key "quiz_question_regrades", "quiz_questions"
  add_foreign_key "quiz_question_regrades", "quiz_regrades"
  add_foreign_key "quiz_regrade_runs", "quiz_regrades"
  add_foreign_key "quiz_regrades", "quizzes"
  add_foreign_key "quiz_regrades", "users"
  add_foreign_key "quiz_statistics", "quizzes"
  add_foreign_key "quiz_submission_events", "quiz_submissions"
  add_foreign_key "quiz_submission_events_2018_10", "quiz_submissions"
  add_foreign_key "quiz_submission_events_2018_11", "quiz_submissions"
  add_foreign_key "quiz_submission_events_2018_12", "quiz_submissions"
  add_foreign_key "quiz_submissions", "quizzes"
  add_foreign_key "quiz_submissions", "users"
  add_foreign_key "quizzes", "assignments"
  add_foreign_key "quizzes", "cloned_items"
  add_foreign_key "report_snapshots", "accounts"
  add_foreign_key "role_overrides", "accounts", column: "context_id"
  add_foreign_key "role_overrides", "roles"
  add_foreign_key "roles", "accounts"
  add_foreign_key "roles", "accounts", column: "root_account_id"
  add_foreign_key "rubric_assessments", "rubric_associations"
  add_foreign_key "rubric_assessments", "rubrics"
  add_foreign_key "rubric_assessments", "users"
  add_foreign_key "rubric_assessments", "users", column: "assessor_id"
  add_foreign_key "rubric_associations", "rubrics"
  add_foreign_key "rubrics", "rubrics"
  add_foreign_key "rubrics", "users"
  add_foreign_key "score_metadata", "scores"
  add_foreign_key "score_statistics", "assignments"
  add_foreign_key "scores", "enrollments"
  add_foreign_key "scores", "grading_periods"
  add_foreign_key "session_persistence_tokens", "pseudonyms"
  add_foreign_key "shared_brand_configs", "accounts"
  add_foreign_key "shared_brand_configs", "brand_configs", column: "brand_config_md5", primary_key: "md5"
  add_foreign_key "sis_batch_errors", "accounts", column: "root_account_id"
  add_foreign_key "sis_batch_errors", "sis_batches"
  add_foreign_key "sis_batch_roll_back_data", "sis_batches"
  add_foreign_key "sis_batches", "attachments", column: "errors_attachment_id"
  add_foreign_key "sis_batches", "enrollment_terms", column: "batch_mode_term_id"
  add_foreign_key "sis_batches", "users"
  add_foreign_key "sis_post_grades_statuses", "course_sections"
  add_foreign_key "sis_post_grades_statuses", "courses"
  add_foreign_key "sis_post_grades_statuses", "users"
  add_foreign_key "stream_item_instances", "users"
  add_foreign_key "submission_comments", "moderated_grading_provisional_grades", column: "provisional_grade_id"
  add_foreign_key "submission_comments", "submissions"
  add_foreign_key "submission_comments", "users", column: "author_id"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submissions", "grading_periods"
  add_foreign_key "submissions", "groups"
  add_foreign_key "submissions", "media_objects"
  add_foreign_key "submissions", "quiz_submissions"
  add_foreign_key "submissions", "users"
  add_foreign_key "switchman_shards", "switchman_shards", column: "delayed_jobs_shard_id"
  add_foreign_key "terms_of_service_contents", "accounts"
  add_foreign_key "terms_of_services", "accounts"
  add_foreign_key "user_account_associations", "accounts"
  add_foreign_key "user_account_associations", "users"
  add_foreign_key "user_merge_data", "users"
  add_foreign_key "user_merge_data_records", "user_merge_data", column: "user_merge_data_id"
  add_foreign_key "user_notes", "users"
  add_foreign_key "user_notes", "users", column: "created_by_id"
  add_foreign_key "user_observers", "users"
  add_foreign_key "user_observers", "users", column: "observer_id"
  add_foreign_key "user_profile_links", "user_profiles"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "user_services", "users"
  add_foreign_key "web_conference_participants", "users"
  add_foreign_key "web_conference_participants", "web_conferences"
  add_foreign_key "web_conferences", "users"
  add_foreign_key "wiki_pages", "assignments"
  add_foreign_key "wiki_pages", "assignments", column: "old_assignment_id"
  add_foreign_key "wiki_pages", "cloned_items"
  add_foreign_key "wiki_pages", "users"
  add_foreign_key "wiki_pages", "wikis"
end
