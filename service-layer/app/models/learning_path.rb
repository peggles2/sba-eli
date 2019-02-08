# == Schema Information
#
# Table name: courses
#
#  id                                   :bigint(8)        not null
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

class LearningPath < ApplicationRecord
  include Contentable

  self.table_name = "courses"

  acts_as_taggable_on :subjects
  acts_as_taggable_on :duration

  serialize :settings
end
