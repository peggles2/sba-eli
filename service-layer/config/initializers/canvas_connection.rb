CANVAS_DATABASE_CONFIG = YAML::load(ERB.new(File.read(Rails.root.join("config","canvas_database.yml"))).result)[Rails.env]
