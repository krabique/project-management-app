ThinkingSphinx::Index.define :project, :with => :real_time do
  indexes title
  indexes description
  indexes tags
end
