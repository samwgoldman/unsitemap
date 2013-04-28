class Page
  attr_reader :loc, :lastmod, :changefreq, :priority

  def initialize(loc, lastmod, changefreq, priority)
    @loc, @lastmod, @changefreq, @priority = loc, lastmod, changefreq, priority
  end

  def ==(other)
    loc == other.loc
  end
end
