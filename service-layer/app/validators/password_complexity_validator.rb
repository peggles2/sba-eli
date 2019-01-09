class PasswordComplexityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+/.match?(value)
      default = "Must include at least one lowercase letter, one uppercase letter, and one digit"
      record.errors[attribute] << (options[:message] || default)
    end
  end
end
