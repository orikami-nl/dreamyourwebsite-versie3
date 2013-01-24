module PostsHelper
  include ActsAsTaggableOn::TagsHelper

  def markdown(text)
    markdown_renderer = Redcarpet::Markdown.new(HTMLwithPygments, {:fenced_code_blocks => true, :autolink => true})
    markdown_renderer.render(text).html_safe
  end

end
