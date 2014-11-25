class VerbList
  def self.all
    @all ||= YAML.load_file('config/verbs.yml').map &:deep_symbolize_keys
  end
end
