require "open-uri"
require "nokogiri"
require "zlib"

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
      sitemap.xpath("/s:urlset/s:url/s:loc", namespaces).each do |element|
        yield element.text
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
