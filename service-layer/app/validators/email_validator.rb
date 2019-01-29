class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI::MailTo::EMAIL_REGEXP.match?(value.to_s)
      record.errors[attribute] << (options[:message] || "is not a vaild email")
    end
  end
end
