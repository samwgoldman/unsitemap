require "open-uri"
require "nokogiri"
require "zlib"
require "page"

class Sitemap
  def initialize(uri)
    @uri = uri
  end

  def each(&block)
    sitemap = open(@uri) do |f|
      f = Zlib::GzipReader.new(f) if @uri =~ /\.gz\Z/
      Nokogiri::XML(f)
    end

    case sitemap.root.name
    when "urlset"
      sitemap.xpath("/s:urlset/s:url", namespaces).each do |element|
        loc = element.xpath("s:loc", namespaces)
        lastmod = element.xpath("s:lastmod", namespaces)
        changefreq = element.xpath("s:changefreq", namespaces)
        priority = element.xpath("s:priority", namespaces)
        page = Page.new(
          URI.parse(loc.text),
          Date.parse(lastmod.text),
          changefreq.text,
          Float(priority.text)
        )
        yield page
      end
    when "sitemapindex"
      sitemap.xpath("/s:sitemapindex/s:sitemap/s:loc", namespaces).each do |element|
        Sitemap.new(element.text).each(&block)
      end
    else
      raise "Unknown sitemap format"
    end
  end

  def namespaces
    { "s" => "http://www.sitemaps.org/schemas/sitemap/0.9" }
  end
end
