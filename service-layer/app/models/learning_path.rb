# == Schema Information
#
# Table name: courses
#
#  id                                   :bigint(8)        not null, primary key
#  name                                 :string(255)
#  account_id                           :bigint(8)        not null
#  group_weighting_scheme               :string(255)
#  workflow_state                       :string(255)      not null
#  uuid                                 :string(255)
#  start_at                             :datetime
#  conclude_at                          :datetime
#  grading_standard_id                  :bigint(8)
#  is_public                            :boolean
#  allow_student_wiki_edits             :boolean
#  created_at                           :datetime
#  updated_at                           :datetime
#  show_public_context_messages         :boolean
#  syllabus_body                        :text
#  allow_student_forum_attachments      :boolean          default(FALSE)
#  default_wiki_editing_roles           :string(255)
#  wiki_id                              :bigint(8)
#  allow_student_organized_groups       :boolean          default(TRUE)
#  course_code                          :string(255)
#  default_view                         :string(255)
#  abstract_course_id                   :bigint(8)
#  root_account_id                      :bigint(8)        not null
#  enrollment_term_id                   :bigint(8)        not null
#  sis_source_id                        :string(255)
#  sis_batch_id                         :bigint(8)
#  open_enrollment                      :boolean
#  storage_quota                        :bigint(8)
#  tab_configuration                    :text
#  allow_wiki_comments                  :boolean
#  turnitin_comments                    :text
#  self_enrollment                      :boolean
#  license                              :string(255)
#  indexed                              :boolean
#  restrict_enrollments_to_course_dates :boolean
#  template_course_id                   :bigint(8)
#  locale                               :string(255)
#  settings                             :text
#  replacement_course_id                :bigint(8)
#  stuck_sis_fields                     :text
#  public_description                   :text
#  self_enrollment_code                 :string(255)
#  self_enrollment_limit                :integer
#  integration_id                       :string(255)
#  time_zone                            :string(255)
#  lti_context_id                       :string(255)
#  turnitin_id                          :bigint(8)
#  show_announcements_on_home_page      :boolean
#  home_page_announcement_limit         :integer
#  latest_outcome_import_id             :bigint(8)
#
# Indexes
#
#  index_courses_on_abstract_course_id                 (abstract_course_id) WHERE (abstract_course_id IS NOT NULL)
#  index_courses_on_account_id                         (account_id)
#  index_courses_on_enrollment_term_id                 (enrollment_term_id)
#  index_courses_on_integration_id                     (integration_id,root_account_id) UNIQUE WHERE (integration_id IS NOT NULL)
#  index_courses_on_lti_context_id                     (lti_context_id) UNIQUE
#  index_courses_on_root_account_id                    (root_account_id)
#  index_courses_on_self_enrollment_code               (self_enrollment_code) UNIQUE WHERE (self_enrollment_code IS NOT NULL)
#  index_courses_on_sis_batch_id                       (sis_batch_id) WHERE (sis_batch_id IS NOT NULL)
#  index_courses_on_sis_source_id_and_root_account_id  (sis_source_id,root_account_id) UNIQUE WHERE (sis_source_id IS NOT NULL)
#  index_courses_on_template_course_id                 (template_course_id)
#  index_courses_on_uuid                               (uuid)
#  index_courses_on_wiki_id                            (wiki_id) WHERE (wiki_id IS NOT NULL)
#
# Foreign Keys
#
#  fk_rails_...  (abstract_course_id => abstract_courses.id)
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (enrollment_term_id => enrollment_terms.id)
#  fk_rails_...  (latest_outcome_import_id => outcome_imports.id)
#  fk_rails_...  (root_account_id => accounts.id)
#  fk_rails_...  (sis_batch_id => sis_batches.id)
#  fk_rails_...  (template_course_id => courses.id)
#  fk_rails_...  (wiki_id => wikis.id)
#

class LearningPath < ApplicationRecord
  include Contentable

  self.table_name = "courses"

  acts_as_taggable_on :subjects
  acts_as_taggable_on :duration

  serialize :settings
end
