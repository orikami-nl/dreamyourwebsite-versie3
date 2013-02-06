 xml.instruct!
xml.urlset(
  'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9",
  'xmlns:image'.to_sym => "http://www.google.com/schemas/sitemap-image/1.1"
) do
  @not_so_static_pages.each do |page|
    xml.url do
      xml.loc "#{page}"
      xml.changefreq("weekly")
    end
  end
  @static_pages.each do |page|
    xml.url do
      xml.loc "#{page}"
      xml.changefreq("monthly")
    end
  end
  @really_static_pages.each do |page|
    xml.url do
      xml.loc "#{page}"
      xml.changefreq("yearly")
    end
  end
  @associates.each do |associtate|
    xml.url do
      xml.loc "#{associate_url(associtate)}"
      xml.changefreq("monthly")
    end
  end
  @posts.each do |post|
    xml.url do
      xml.loc "#{post_url(post)}"
      xml.lastmod post.updated_at.strftime("%F")
      xml.changefreq("monthly")
    end
  end
  @projects.each do |project|
    xml.url do
      xml.loc "#{project_url(project)}"
      xml.lastmod project.updated_at.strftime("%F")
      xml.changefreq("monthly")
      if project.picture?
        xml.image :image do
          xml.image :loc, "#{project.picture}"
        end
      end
    end
  end

end
