require_relative "../lib/sitemap"

describe Sitemap do
  it "enumerates sitemap entries" do
    sitemap = Sitemap.new("spec/fixtures/sitemap.xml")
    urls = []
    sitemap.each { |url| urls << url }
    urls.should eq(%w{one two})
  end

  it "doesn't mind gzipped sitemaps" do
    sitemap = Sitemap.new("spec/fixtures/sitemap.xml.gz")
    urls = []
    sitemap.each { |url| urls << url }
    urls.should eq(%w{one two})
  end

  it "recursively enumerates sitemap indexes" do
    sitemap = Sitemap.new("spec/fixtures/sitemap_index.xml")
    urls = []
    sitemap.each { |url| urls << url }
    urls.should eq(%w{one two three four})
  end
end
