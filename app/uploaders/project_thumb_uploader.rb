class ProjectThumbUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :fog
  end

  version :tablet do
    process :resize_to_fill => [244, 138]
    process :pad
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def pad
    manipulate!(:format => 'png') do |img|
      padding = Magick::Image.read("#{Rails.root}/app/assets/images/tablet.png").first
      gloss = Magick::Image.read("#{Rails.root}/app/assets/images/tablet-gloss.png").first
      img_wo_gloss = padding.composite(img, 28, 28, Magick::OverCompositeOp)
      img = img_wo_gloss.composite(gloss, 0, 0, Magick::SoftLightCompositeOp)
    end
  end

  def filename
    super.chomp(File.extname(super)) + '.png'
  end

end

