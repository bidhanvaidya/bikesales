SitemapGenerator::Sitemap.default_host = "http://bikes.bechnu.com"
SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/sitemap-generator/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  add '/showroom', :priority=> 0.95
  add new_bike_path, :priority=> 0.7, :changefreq=> 'yearly'
  add '/users/signin', :priority=> 0.75, :changefreq=> 'never'
  add '/', :priority => 1
  add bikes_path, :changefreq => 'hourly', :priority => 0.9
  Bike.each do |doc|
    add bike_path(doc), :lastmod => doc.updated
  end
   add bikes_path, :changefreq => 'weekly', :priority => 0.9
    BikeSpec.latest.with_price.each do |doc|
    add bike_spec_path(doc), :lastmod => doc.updated
  end
  add contacts_path, :priority => 0.5
  add how_it_works_path, :priority => 0.5
  add terms_and_conditions_path, :priority => 0.5, :changefreq => 'yearly'
  add about_us_path, :priority => 0.6, :changefreq=> 'monthly'

end