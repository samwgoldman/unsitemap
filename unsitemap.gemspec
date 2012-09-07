Gem::Specification.new do |s|
  s.name = "unsitemap"
  s.version = "0.0.1"
  s.platform = Gem::Platform::RUBY
  s.summary = "Sitemap Consumer"
  s.homepage = "https://github.com/samwgoldman/unsitemap"
  s.author = "Sam Goldman"
  s.files = Dir["lib/**/*"]
  s.require_path = "lib"
  s.add_runtime_dependency "nokogiri"
  s.add_development_dependency "rspec"
end
