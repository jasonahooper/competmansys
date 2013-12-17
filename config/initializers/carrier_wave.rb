if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.enable_processing = false
  end
end

if Rails.env.test? or Rails.env.cucumber? or Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['awsid'],                   # required
      :aws_secret_access_key  => ENV['awskey'],             # required
      # :region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
      # :host                   => 's3.example.com',             # optional, defaults to nil
      # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = 'competmansys'                     # required
    # config.fog_public     = false                                   # optional, defaults to true
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
end