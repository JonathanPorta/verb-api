class VerbList
  def self.all
    @all ||= YAML.load_file('config/verbs.yml').symbolize_keys
  end
end
