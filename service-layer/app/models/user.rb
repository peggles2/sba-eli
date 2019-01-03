class User
  include ActiveModel::Model

  attr_accessor :id,
                :name,
                :sortable_name,
                :short_name,
                :login_id

  def locale=(value)
    @locale = value
  end

  def locale
    @locale
  end

  class << self
    def from_canvas_json(json)
      user = User.new
      user.id = json["id"].to_i
      user.name = json["name"]
      user.sortable_name = json["sortable_name"]
      user.short_name = json["short_name"]
      user.login_id = json["login_id"]
      user
    end
  end
end
