CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/"
  config.storage = :fog
  config.permissions = 0666
  CONFIG = YAML.load_file(Rails.root.join("config/CarrierWave.yml"))[Rails.env]
  APP_ID = CONFIG['app_id']
  SECRET = CONFIG['secret_key']
  BUCKET = CONFIG['bucket']
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => APP_ID,
    :aws_secret_access_key  => SECRET,
  }
  config.fog_directory  = BUCKET
end