CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
      provider:               'Google',
      google_project: ENV['GOOGLE_PROJECT'],
      google_json_key_string: ENV['GOOGLE_JSON_KEY_STRING']
  }
  config.fog_directory = ENV['GOOGLE_BUCKET']
end