# encoding: utf-8

class ResumeUploader < CarrierWave::Uploader::Base

  require 'RMagick'
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:


  storage :file
  attr_accessor :name
  attr_accessor :email
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #binding.pry
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :resume_parser
 # process :convert_to_png

  def resume_parser
    #lines = parsed_file.split "\n"
    parsed_file=`pdftotext #{self.path} -`
    regex = Regexp.new(/\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/)
    emails = parsed_file.scan(regex).uniq
    lines = parsed_file.split "\n"
    @name=lines[0]
    @email=emails[0]

=begin

    pdf_file_name = "#{self.name}"
    im = Magick::Image.read(pdf_file_name)
    im[0].write(pdf_file_name + ".jpg")
=end



  end
  def convert_to_png
=begin
    Magick::ImageList.new("#{self.path}") do
      self.quality = 80
      self.density = '300'
      self.colorspace = Magick::RGBColorspace
      self.interlace = Magick::NoInterlace
    end.each_with_index do |img, i|
      img.resize_to_fit!(800, 800)
      img.write("test-#{i}.jpg")
    end
=end

    original_pdf = File.open("#{self.path}", 'rb').read
    image = Magick::Image::from_blob(original_pdf) do
      self.format = 'PDF'
      self.quality = 100
      self.density = 144
    end
    image[0].format = 'JPG'
    image[0].to_blob
puts "------------------------------------------------public/#{store_dir}"
    image[0].write("public/#{store_dir}" + "#{self.name}.jpg")
  end



  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
