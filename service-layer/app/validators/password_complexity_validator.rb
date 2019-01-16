class PasswordComplexityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+/.match?(value)
      default = "Must include at least one lowercase letter, one uppercase letter, and one digit"
      record.errors[attribute] << (options[:message] || default)
    end

    specials = %w( ! @ # + = ^ $ * . [ ] { } \( \) ? - " % & \/ \\ \, > < ' : ; | _ ~ `)
    unless specials.any? {|s| value.include? s}
      default = "Must include at least one special character"
      record.errors[attribute] << (options[:message] || default)
    end

    unless value.length > 7
      default = "Must be at least 8 characters"
      record.errors[attribute] << (options[:message] || default)
    end
  end
end
