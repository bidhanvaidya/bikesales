class SitemapsController < ApplicationController

  def show
    # Redirect to CloudFront and S3
    redirect_to "https://s3.amazonaws.com/sitemap_development/sitemaps/sitemap.xml.gz"
  end

end