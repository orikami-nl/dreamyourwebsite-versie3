class HeadshotUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  #include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :fog
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [80, 80, Magick::NorthGravity]
  end

  version :medium do
    process :resize_to_fill => [160, 160, Magick::NorthGravity]
  end

  version :large do
    process :resize_to_fill => [320, 400, Magick::NorthGravity]
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
