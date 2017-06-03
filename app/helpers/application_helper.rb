module ApplicationHelper
  def tag_links_for_project(project)
    raw project.tag_list.map { |t| link_to t, tag_path(t) }.join(', ')
  end
end
