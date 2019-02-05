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

<<<<<<< Updated upstream
ActiveRecord::Schema.define(version: 2019_01_28_193107) do
=======
ActiveRecord::Schema.define(version: 2019_02_01_180344) do
>>>>>>> Stashed changes

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "abstract_courses", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "access_tokens", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "account_notification_roles", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "account_notification_id", null: false
    t.bigint "role_id"
  end

  create_table "account_notifications", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "account_report_rows", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "account_report_id", null: false
    t.bigint "account_report_runner_id", null: false
    t.integer "row_number"
    t.string "row", default: [], array: true
    t.datetime "created_at", null: false
  end

  create_table "account_report_runners", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "account_report_id", null: false
    t.string "workflow_state", limit: 255, default: "created", null: false
    t.string "batch_items", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
  end

  create_table "account_reports", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "account_users", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "role_id", null: false
    t.string "workflow_state", default: "active", null: false
    t.bigint "sis_batch_id"
  end

  create_table "accounts", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "alert_criteria", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "alert_id"
    t.string "criterion_type", limit: 255
    t.float "threshold"
  end

  create_table "alerts", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.text "recipients", null: false
    t.integer "repetition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "anonymous_or_moderation_events", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "assignment_id", null: false
    t.bigint "user_id", null: false
    t.bigint "submission_id"
    t.bigint "canvadoc_id"
    t.string "event_type", null: false
    t.jsonb "payload", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointment_group_contexts", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "appointment_group_id"
    t.string "context_code", limit: 255
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointment_group_sub_contexts", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "appointment_group_id"
    t.bigint "sub_context_id"
    t.string "sub_context_type", limit: 255
    t.string "sub_context_code", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointment_groups", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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

  create_table "assessment_question_bank_users", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "assessment_question_bank_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assessment_question_banks", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.text "title"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "migration_id", limit: 255
  end

  create_table "assessment_questions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "assessment_requests", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "asset_user_accesses", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "assignment_configuration_tool_lookups", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "assignment_id", null: false
    t.bigint "tool_id"
    t.string "tool_type", limit: 255, null: false
    t.string "subscription_id"
    t.string "tool_product_code"
    t.string "tool_vendor_code"
    t.string "tool_resource_type_code"
  end

  create_table "assignment_groups", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "assignment_override_students", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assignment_id"
    t.bigint "assignment_override_id", null: false
    t.bigint "user_id", null: false
    t.bigint "quiz_id"
    t.string "workflow_state", default: "active", null: false
  end

  create_table "assignment_overrides", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "assignments", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "attachment_associations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "attachment_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
  end

  create_table "attachments", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "authentication_providers", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "bookmarks_bookmarks", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.string "name", limit: 255, null: false
    t.string "url", limit: 255, null: false
    t.integer "position"
    t.text "json"
  end

  create_table "brand_configs", id: false, force: :cascade do |t|
    t.string "md5", limit: 32, null: false
    t.text "variables"
    t.boolean "share", default: false, null: false
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.text "js_overrides"
    t.text "css_overrides"
    t.text "mobile_js_overrides"
    t.text "mobile_css_overrides"
    t.string "parent_md5", limit: 255
  end

  create_table "calendar_events", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "canvadocs", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "document_id", limit: 255
    t.string "process_state", limit: 255
    t.bigint "attachment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_annotations"
  end

  create_table "canvadocs_submissions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "canvadoc_id"
    t.bigint "crocodoc_document_id"
    t.bigint "submission_id", null: false
  end

  create_table "cloned_items", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "original_item_id"
    t.string "original_item_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collaborations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "collaborators", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id"
    t.bigint "collaboration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "authorized_service_user_id", limit: 255
    t.bigint "group_id"
  end

  create_table "communication_channels", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "content_exports", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "content_migrations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "content_participation_counts", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "content_type", limit: 255
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.bigint "user_id"
    t.integer "unread_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_participations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "content_type", limit: 255, null: false
    t.bigint "content_id", null: false
    t.bigint "user_id", null: false
    t.string "workflow_state", limit: 255, null: false
  end

  create_table "content_tags", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "context_external_tool_assignment_lookups", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "assignment_id", null: false
    t.bigint "context_external_tool_id", null: false
  end

  create_table "context_external_tool_placements", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "placement_type", limit: 255
    t.bigint "context_external_tool_id", null: false
  end

  create_table "context_external_tools", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "context_module_progressions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "context_modules", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "conversation_batches", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "conversation_message_participants", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "conversation_message_id"
    t.bigint "conversation_participant_id"
    t.text "tags"
    t.bigint "user_id"
    t.string "workflow_state", limit: 255
    t.datetime "deleted_at"
  end

  create_table "conversation_messages", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "conversation_participants", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "conversations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "private_hash", limit: 255
    t.boolean "has_attachments", default: false, null: false
    t.boolean "has_media_objects", default: false, null: false
    t.text "tags"
    t.text "root_account_ids"
    t.string "subject", limit: 255
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.datetime "updated_at"
  end

  create_table "course_account_associations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "course_id", null: false
    t.bigint "account_id", null: false
    t.integer "depth", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "course_section_id"
  end

  create_table "course_sections", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "courses", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "crocodoc_documents", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "uuid", limit: 255
    t.string "process_state", limit: 255
    t.bigint "attachment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_data", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.text "data"
    t.string "namespace", limit: 255
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_gradebook_column_data", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "content", limit: 255, null: false
    t.bigint "user_id", null: false
    t.bigint "custom_gradebook_column_id", null: false
  end

  create_table "custom_gradebook_columns", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "title", limit: 255, null: false
    t.integer "position", null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "teacher_notes", default: false, null: false
    t.boolean "read_only", default: false, null: false
  end

  create_table "delayed_jobs", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "delayed_messages", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "delayed_notifications", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "notification_id", null: false
    t.bigint "asset_id", null: false
    t.string "asset_type", limit: 255, null: false
    t.text "recipient_keys"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "developer_key_account_bindings", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "account_id", null: false
    t.bigint "developer_key_id", null: false
    t.string "workflow_state", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "developer_keys", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "discussion_entries", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "discussion_entry_participants", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "discussion_entry_id", null: false
    t.bigint "user_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.boolean "forced_read_state"
    t.integer "rating"
  end

  create_table "discussion_topic_materialized_views", id: false, force: :cascade do |t|
    t.bigint "discussion_topic_id", null: false
    t.string "json_structure", limit: 10485760
    t.string "participants_array", limit: 10485760
    t.string "entry_ids_array", limit: 10485760
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "generation_started_at"
  end

  create_table "discussion_topic_participants", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "discussion_topic_id", null: false
    t.bigint "user_id", null: false
    t.integer "unread_entry_count", default: 0, null: false
    t.string "workflow_state", limit: 255, null: false
    t.boolean "subscribed"
  end

  create_table "discussion_topic_section_visibilities", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "discussion_topic_id", null: false
    t.bigint "course_section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", limit: 255, null: false
  end

  create_table "discussion_topics", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "enrollment_dates_overrides", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "enrollment_term_id"
    t.string "enrollment_type", limit: 255
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollment_states", id: false, force: :cascade do |t|
    t.bigint "enrollment_id", null: false
    t.string "state", limit: 255
    t.boolean "state_is_current", default: false, null: false
    t.datetime "state_started_at"
    t.datetime "state_valid_until"
    t.boolean "restricted_access", default: false, null: false
    t.boolean "access_is_current", default: false, null: false
    t.integer "lock_version", default: 0, null: false
  end

  create_table "enrollment_terms", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "enrollments", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "eportfolio_categories", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "eportfolio_id", null: false
    t.string "name", limit: 255
    t.integer "position"
    t.string "slug", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eportfolio_entries", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "eportfolios", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.string "name", limit: 255
    t.boolean "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uuid", limit: 255
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "deleted_at"
  end

  create_table "epub_exports", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "content_export_id"
    t.bigint "course_id"
    t.bigint "user_id"
    t.string "workflow_state", limit: 255, default: "created"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", limit: 255
  end

  create_table "error_reports", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "event_stream_failures", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "operation", limit: 255, null: false
    t.string "event_stream", limit: 255, null: false
    t.string "record_id", limit: 255, null: false
    t.text "payload", null: false
    t.text "exception"
    t.text "backtrace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "external_feed_entries", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "external_feeds", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "external_integration_keys", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "key_value", limit: 255, null: false
    t.string "key_type", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "failed_jobs", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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

  create_table "favorites", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id"
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

<<<<<<< Updated upstream
=======
  create_table "fearless_learning_path_custom_data", force: :cascade do |t|
    t.integer "learning_path_id", null: false
    t.string "time"
    t.string "description"
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_path_id"], name: "index_fearless_learning_path_custom_data_on_learning_path_id", unique: true
  end

>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
  create_table "feature_flags", force: :cascade do |t|
=======
  create_table "feature_flags", id: false, force: :cascade do |t|
    t.bigint "id", null: false
>>>>>>> Stashed changes
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "feature", limit: 255, null: false
    t.string "state", limit: 255, default: "allowed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "folders", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "gradebook_csvs", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.bigint "attachment_id", null: false
    t.bigint "progress_id", null: false
    t.bigint "course_id", null: false
  end

  create_table "gradebook_uploads", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.bigint "progress_id", null: false
    t.text "gradebook"
  end

  create_table "grading_period_groups", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "course_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.string "title", limit: 255
    t.boolean "weighted"
    t.boolean "display_totals_for_all_grading_periods", default: false, null: false
  end

  create_table "grading_periods", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.float "weight"
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", limit: 255
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.integer "grading_period_group_id", null: false
    t.datetime "close_date"
  end

  create_table "grading_standards", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "group_categories", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "group_memberships", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "group_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id", null: false
    t.string "uuid", limit: 255, null: false
    t.bigint "sis_batch_id"
    t.boolean "moderator"
  end

  create_table "groups", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "ignores", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "asset_type", limit: 255, null: false
    t.bigint "asset_id", null: false
    t.bigint "user_id", null: false
    t.string "purpose", limit: 255, null: false
    t.boolean "permanent", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "late_policies", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "learning_outcome_groups", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "learning_outcome_question_results", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "learning_outcome_results", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "learning_outcomes", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "live_assessments_assessments", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "key", limit: 255, null: false
    t.string "title", limit: 255, null: false
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "live_assessments_results", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.bigint "assessor_id", null: false
    t.bigint "assessment_id", null: false
    t.boolean "passed", null: false
    t.datetime "assessed_at", null: false
  end

  create_table "live_assessments_submissions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.bigint "assessment_id", null: false
    t.float "possible"
    t.float "score"
    t.datetime "assessed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lti_line_items", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.float "score_maximum", null: false
    t.string "label", null: false
    t.string "resource_id"
    t.string "tag"
    t.bigint "lti_resource_link_id"
    t.bigint "assignment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lti_links", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "lti_message_handlers", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "message_type", limit: 255, null: false
    t.string "launch_path", limit: 255, null: false
    t.text "capabilities"
    t.text "parameters"
    t.bigint "resource_handler_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tool_proxy_id"
  end

  create_table "lti_product_families", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "lti_resource_handlers", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "resource_type_code", limit: 255, null: false
    t.string "placements", limit: 255
    t.string "name", limit: 255, null: false
    t.text "description"
    t.text "icon_info"
    t.bigint "tool_proxy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lti_resource_links", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "resource_link_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lti_resource_placements", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "placement", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "message_handler_id"
  end

  create_table "lti_results", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "lti_tool_configurations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "developer_key_id", null: false
    t.jsonb "settings", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "disabled_placements", default: [], array: true
    t.text "custom_fields"
  end

  create_table "lti_tool_consumer_profiles", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.text "services"
    t.text "capabilities"
    t.string "uuid", null: false
    t.bigint "developer_key_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lti_tool_proxies", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "lti_tool_proxy_bindings", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "tool_proxy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled", default: true, null: false
  end

  create_table "lti_tool_settings", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "master_courses_child_content_tags", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "child_subscription_id", null: false
    t.string "content_type", limit: 255, null: false
    t.bigint "content_id", null: false
    t.text "downstream_changes"
    t.string "migration_id"
  end

  create_table "master_courses_child_subscriptions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "master_template_id", null: false
    t.bigint "child_course_id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.boolean "use_selective_copy", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "master_courses_master_content_tags", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "master_template_id", null: false
    t.string "content_type", limit: 255, null: false
    t.bigint "content_id", null: false
    t.bigint "current_migration_id"
    t.text "restrictions"
    t.string "migration_id"
    t.boolean "use_default_restrictions", default: false, null: false
  end

  create_table "master_courses_master_migrations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "master_courses_master_templates", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "course_id", null: false
    t.boolean "full_course", default: true, null: false
    t.string "workflow_state", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "active_migration_id"
    t.text "default_restrictions"
    t.boolean "use_default_restrictions_by_type", default: false, null: false
    t.text "default_restrictions_by_type"
  end

  create_table "master_courses_migration_results", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "master_migration_id", null: false
    t.bigint "content_migration_id", null: false
    t.bigint "child_subscription_id", null: false
    t.string "import_type", null: false
    t.string "state", null: false
    t.text "results"
  end

  create_table "media_objects", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "media_tracks", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id"
    t.bigint "media_object_id", null: false
    t.string "kind", limit: 255, default: "subtitles"
    t.string "locale", limit: 255, default: "en"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "migration_issues", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "content_migration_id", null: false
    t.text "description"
    t.string "workflow_state", limit: 255, null: false
    t.text "fix_issue_html_url"
    t.string "issue_type", limit: 255, null: false
    t.bigint "error_report_id"
    t.text "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moderated_grading_provisional_grades", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "moderated_grading_selections", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "assignment_id", null: false
    t.bigint "student_id", null: false
    t.bigint "selected_provisional_grade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moderation_graders", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "anonymous_id", limit: 5, null: false
    t.bigint "assignment_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "slot_taken", default: true, null: false
  end

  create_table "notification_endpoints", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "access_token_id", null: false
    t.string "token", limit: 255, null: false
    t.string "arn", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", default: "active", null: false
  end

  create_table "notification_policies", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "notification_id"
    t.bigint "communication_channel_id", null: false
    t.string "frequency", limit: 255, default: "immediately", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "workflow_state", limit: 255, null: false
    t.string "name", limit: 255
    t.string "subject", limit: 255
    t.string "category", limit: 255
    t.integer "delay_for", default: 120
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "main_link", limit: 255
  end

  create_table "oauth_requests", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "oauth_states", force: :cascade do |t|
    t.string "state"
    t.text "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state"], name: "index_oauth_states_on_state"
  end

  create_table "observer_alert_thresholds", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "alert_type", null: false
    t.string "threshold"
    t.string "workflow_state", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "observer_id", null: false
  end

  create_table "observer_alerts", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "observer_pairing_codes", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.string "code", limit: 10, null: false
    t.datetime "expires_at", null: false
    t.string "workflow_state", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "one_time_passwords", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.string "code", null: false
    t.boolean "used", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "originality_reports", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "outcome_import_errors", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "outcome_import_id", null: false
    t.string "message", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row"
    t.boolean "failure", default: false, null: false
  end

  create_table "outcome_imports", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "outcome_proficiencies", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outcome_proficiency_ratings", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "outcome_proficiency_id", null: false
    t.string "description", limit: 255, null: false
    t.float "points", null: false
    t.boolean "mastery", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_comments", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.text "message"
    t.bigint "page_id"
    t.string "page_type", limit: 255
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_views", id: false, force: :cascade do |t|
    t.string "request_id", limit: 255, null: false
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
  end

  create_table "parallel_importers", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "planner_notes", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "planner_overrides", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "plannable_type", null: false
    t.bigint "plannable_id", null: false
    t.bigint "user_id", null: false
    t.string "workflow_state"
    t.boolean "marked_complete", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "dismissed", default: false, null: false
  end

  create_table "plugin_settings", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", limit: 255, default: "", null: false
    t.text "settings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "disabled"
  end

  create_table "polling_poll_choices", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "text", limit: 255
    t.boolean "is_correct", default: false, null: false
    t.bigint "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "polling_poll_sessions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.boolean "is_published", default: false, null: false
    t.boolean "has_public_results", default: false, null: false
    t.bigint "course_id", null: false
    t.bigint "course_section_id"
    t.bigint "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "polling_poll_submissions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "poll_id", null: false
    t.bigint "poll_choice_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "poll_session_id", null: false
  end

  create_table "polling_polls", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "question", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
  end

  create_table "profiles", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "root_account_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "context_id", null: false
    t.string "title", limit: 255
    t.string "path", limit: 255
    t.text "description"
    t.text "data"
    t.string "visibility", limit: 255
    t.integer "position"
  end

  create_table "progresses", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "pseudonyms", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "purgatories", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "attachment_id", null: false
    t.bigint "deleted_by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", default: "active", null: false
    t.string "old_filename", null: false
    t.string "old_display_name", limit: 255
    t.string "old_content_type", limit: 255
  end

  create_table "quiz_groups", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "quiz_id", null: false
    t.string "name", limit: 255
    t.integer "pick_count"
    t.float "question_points"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "migration_id", limit: 255
    t.bigint "assessment_question_bank_id"
  end

  create_table "quiz_question_regrades", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "quiz_regrade_id", null: false
    t.bigint "quiz_question_id", null: false
    t.string "regrade_option", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_questions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "quiz_regrade_runs", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "quiz_regrade_id", null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_regrades", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.bigint "quiz_id", null: false
    t.integer "quiz_version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_statistics", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "quiz_id"
    t.boolean "includes_all_versions"
    t.boolean "anonymous"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "report_type", limit: 255
    t.boolean "includes_sis_ids"
  end

  create_table "quiz_submission_events", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "attempt", null: false
    t.string "event_type", limit: 255, null: false
    t.bigint "quiz_submission_id", null: false
    t.text "event_data"
    t.datetime "created_at", null: false
    t.datetime "client_timestamp"
  end

  create_table "quiz_submission_events_2018_10", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('quiz_submission_events_id_seq'::regclass)" }, null: false
    t.integer "attempt", null: false
    t.string "event_type", limit: 255, null: false
    t.bigint "quiz_submission_id", null: false
    t.text "event_data"
    t.datetime "created_at", null: false
    t.datetime "client_timestamp"
  end

  create_table "quiz_submission_events_2018_11", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('quiz_submission_events_id_seq'::regclass)" }, null: false
    t.integer "attempt", null: false
    t.string "event_type", limit: 255, null: false
    t.bigint "quiz_submission_id", null: false
    t.text "event_data"
    t.datetime "created_at", null: false
    t.datetime "client_timestamp"
  end

  create_table "quiz_submission_events_2018_12", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('quiz_submission_events_id_seq'::regclass)" }, null: false
    t.integer "attempt", null: false
    t.string "event_type", limit: 255, null: false
    t.bigint "quiz_submission_id", null: false
    t.text "event_data"
    t.datetime "created_at", null: false
    t.datetime "client_timestamp"
  end

  create_table "quiz_submission_snapshots", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "quiz_submission_id"
    t.integer "attempt"
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_submissions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "quizzes", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "report_snapshots", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "report_type", limit: 255
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "account_id"
  end

  create_table "role_overrides", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "roles", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", limit: 255, null: false
    t.string "base_role_type", limit: 255, null: false
    t.bigint "account_id"
    t.string "workflow_state", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.bigint "root_account_id"
  end

  create_table "rubric_assessments", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "rubric_associations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "rubrics", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "score_metadata", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "score_id", null: false
    t.json "calculation_details", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", default: "active", null: false
  end

  create_table "score_statistics", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "assignment_id", null: false
    t.float "minimum", null: false
    t.float "maximum", null: false
    t.float "mean", null: false
    t.integer "count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "session_persistence_tokens", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "token_salt", limit: 255, null: false
    t.string "crypted_token", limit: 255, null: false
    t.bigint "pseudonym_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "session_id", limit: 255, null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", limit: 255
    t.text "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shared_brand_configs", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", limit: 255
    t.bigint "account_id"
    t.string "brand_config_md5", limit: 32, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sis_batch_errors", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "sis_batch_id", null: false
    t.bigint "root_account_id", null: false
    t.text "message", null: false
    t.text "backtrace"
    t.string "file", limit: 255
    t.boolean "failure", default: false, null: false
    t.integer "row"
    t.datetime "created_at", null: false
    t.text "row_info"
  end

  create_table "sis_batch_roll_back_data", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "sis_batch_id", null: false
    t.string "context_type", limit: 255, null: false
    t.bigint "context_id", null: false
    t.string "previous_workflow_state", limit: 255, null: false
    t.string "updated_workflow_state", limit: 255, null: false
    t.boolean "batch_mode_delete", default: false, null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sis_batches", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "sis_post_grades_statuses", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "course_id", null: false
    t.bigint "course_section_id"
    t.bigint "user_id"
    t.string "status", limit: 255, null: false
    t.string "message", limit: 255, null: false
    t.datetime "grades_posted_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stream_item_instances", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.bigint "stream_item_id", null: false
    t.boolean "hidden", default: false, null: false
    t.string "workflow_state", limit: 255
    t.string "context_type", limit: 255
    t.bigint "context_id"
  end

  create_table "stream_items", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.text "data", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "context_type", limit: 255
    t.bigint "context_id"
    t.string "asset_type", limit: 255, null: false
    t.bigint "asset_id"
    t.string "notification_category", limit: 255
  end

  create_table "submission_comments", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "submission_versions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "context_id"
    t.string "context_type", limit: 255
    t.bigint "version_id"
    t.bigint "user_id"
    t.bigint "assignment_id"
  end

  create_table "submissions", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "switchman_shards", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", limit: 255
    t.string "database_server_id", limit: 255
    t.boolean "default", default: false, null: false
    t.text "settings"
    t.bigint "delayed_jobs_shard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms_of_service_contents", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.text "content", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "terms_updated_at", null: false
    t.string "workflow_state", null: false
    t.bigint "account_id"
  end

  create_table "terms_of_services", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "terms_type", default: "default", null: false
    t.boolean "passive", default: true, null: false
    t.bigint "terms_of_service_content_id"
    t.bigint "account_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "workflow_state", null: false
  end

  create_table "thumbnails", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "usage_rights", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "context_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "use_justification", limit: 255, null: false
    t.string "license", limit: 255, null: false
    t.text "legal_copyright"
  end

  create_table "user_account_associations", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.bigint "account_id", null: false
    t.integer "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_merge_data", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.bigint "from_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
  end

  create_table "user_merge_data_records", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_merge_data_id", null: false
    t.bigint "context_id", null: false
    t.bigint "previous_user_id", null: false
    t.string "context_type", limit: 255, null: false
    t.string "previous_workflow_state", limit: 255
  end

  create_table "user_notes", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id"
    t.text "note"
    t.string "title", limit: 255
    t.bigint "created_by_id"
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_observers", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "user_id", null: false
    t.bigint "observer_id", null: false
    t.string "workflow_state", limit: 255, default: "active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "sis_batch_id"
    t.bigint "root_account_id"
  end

  create_table "user_profile_links", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "url", limit: 4096
    t.string "title", limit: 255
    t.bigint "user_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.text "bio"
    t.string "title", limit: 255
    t.bigint "user_id"
  end

  create_table "user_services", id: false, force: :cascade do |t|
    t.bigint "id", null: false
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
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "profile_picture"
    t.string "linked_in"
    t.string "zipcode"
    t.integer "percent_ownership"
    t.integer "goal_percent_revenue"
    t.integer "goal_revenue_amount"
    t.integer "goal_percent_increase_employees"
    t.integer "goal_increase_employee_amount"
    t.bigint "race_id", array: true
    t.bigint "ethnicity_id"
    t.bigint "companies_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_users_on_companies_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["ethnicity_id"], name: "index_users_on_ethnicity_id"
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["race_id"], name: "index_users_on_race_id"
    t.index ["user_id"], name: "index_users_on_user_id"
  end

  add_foreign_key "fearless_taggings", "fearless_tags", column: "tag_id"
end
