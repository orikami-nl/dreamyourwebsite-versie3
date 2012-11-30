markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, {:fenced_code_blocks => true})
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "dreamyourweb blog"
    xml.description "A blog about lean stuff"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description markdown.render(post.excerpt).html_safe + markdown.render(post.body).html_safe
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
