require_relative "../lib/sitemap"

describe Sitemap do
  def page_data(sitemap)
    result = []
    sitemap.each do |page|
      result << {
        :loc => page.loc,
        :lastmod => page.lastmod,
        :changefreq => page.changefreq,
        :priority => page.priority
      }
    end
    result
  end

  it "enumerates sitemap entries" do
    sitemap = Sitemap.new("spec/fixtures/sitemap.xml")
    page_data(sitemap).should eq([
      {
        :loc => URI.parse("http://example.com/one"),
        :lastmod => Date.parse("2009-09-22"),
        :changefreq => "monthly",
        :priority => 0.8
      },
      {
        :loc => URI.parse("http://example.com/two"),
        :lastmod => Date.parse("2011-10-10"),
        :changefreq => "daily",
        :priority => 1.0
      }
    ])
  end

  it "doesn't mind gzipped sitemaps" do
    sitemap = Sitemap.new("spec/fixtures/sitemap.xml.gz")
    page_data(sitemap).should eq([
      {
        :loc => URI.parse("http://example.com/one"),
        :lastmod => Date.parse("2009-09-22"),
        :changefreq => "monthly",
        :priority => 0.8
      },
      {
        :loc => URI.parse("http://example.com/two"),
        :lastmod => Date.parse("2011-10-10"),
        :changefreq => "daily",
        :priority => 1.0
      }
    ])
  end

  it "recursively enumerates sitemap indexes" do
    sitemap = Sitemap.new("spec/fixtures/sitemap_index.xml")
    page_data(sitemap).should eq([
      {
        :loc => URI.parse("http://example.com/one"),
        :lastmod => Date.parse("2009-09-22"),
        :changefreq => "monthly",
        :priority => 0.8
      },
      {
        :loc => URI.parse("http://example.com/two"),
        :lastmod => Date.parse("2011-10-10"),
        :changefreq => "daily",
        :priority => 1.0
      },
      {
        :loc => URI.parse("http://example.com/three"),
        :lastmod => Date.parse("1999-12-25"),
        :changefreq => "monthly",
        :priority => 0.6
      },
      {
        :loc => URI.parse("http://example.com/four"),
        :lastmod => Date.parse("2012-01-02"),
        :changefreq => "weekly",
        :priority => 0.2
      }
    ])
  end
end
