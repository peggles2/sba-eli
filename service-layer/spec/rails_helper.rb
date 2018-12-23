ENV["RACK_ENV"] = "test"

require File.expand_path("../config/environment", __dir__)
abort("DATABASE_URL environment variable is set") if ENV["DATABASE_URL"]

require "rspec/rails"
require "support/mocks/request_helper"

# rubocop:disable Rails/FilePath
Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }
# rubocop:enable Rails/FilePath

module Features
  # Extend this module in spec/support/features/*.rb
end

RSpec.configure do |config|
  config.include Features, type: :feature
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.fixture_path = "spec/fixtures"
end

VCR.configure do |config|
  config.default_cassette_options = {
    match_requests_on: [:method],
  }
end

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
