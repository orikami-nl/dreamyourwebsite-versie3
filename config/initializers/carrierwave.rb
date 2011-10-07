CarrierWave.configure do |config|
	config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV['S3_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET'],
    :region => 'eu-west-1'
	}
	config.fog_directory = 'dreamyourweb'
end

