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
