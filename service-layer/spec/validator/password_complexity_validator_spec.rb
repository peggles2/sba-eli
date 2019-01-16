require "rails_helper"

class Validatable
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :password

  validates :password, password_complexity: true
end

RSpec.describe PasswordComplexityValidator do
  subject { Validatable.new(password: password) }

  context "when the password is sufficiently complex" do
    let(:password) { "P@ssw0rd!" }

    it { is_expected.to be_valid }
  end

  context "when the password doesn't have a digit" do
    let(:password) { "P@ssword!" }

    it { is_expected.to_not be_valid }
  end

  context "when the password doesn't have a capital letter" do
    let(:password) { "p@ssw0rd!" }

    it { is_expected.to_not be_valid }
  end

  context "when the password doesn't have a lowercase letter" do
    let(:password) { "P@SSW0RD!" }

    it { is_expected.to_not be_valid }
  end

  context "when the password doesn't have a special character" do
    let(:password) { "Passw0rd1234" }

    it { is_expected.to_not be_valid }
  end

  specials = %w( ! @ # + = ^ $ * . [ ] { } \( \) ? - " % & \/ \\ \, > < ' : ; | _ ~ `)
  specials.each do |c|
    let(:password) { "Passw0rd1234#{c}" }
    it "a password with a #{c} has a special character" do
      expect(subject).to be_valid
    end
  end

  context "when the password isn't long enough" do
    let(:password) { "P@sw0rd" }

    it { is_expected.to_not be_valid }
  end
end
