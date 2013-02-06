require 'net/http'
namespace :sitemap do

  desc "Ping Sitemap"
  task :ping do
    Net::HTTP.get(URI.parse("http://www.google.com/webmasters/tools/ping?sitemap=" + CGI::escape("http://dreamyourweb.nl/sitemap.xml")))
  end

end