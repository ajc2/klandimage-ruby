require "klandimage/version"
require 'rest-client'
require 'json'

module KlandImage
  ALL = -1

  # Upload an image to kland.
  #
  # @param image [File] An image file to upload.
  # @param bucket [String] The bucket to upload to.
  # @return [String] The URL of the uploaded image.
  def self.upload(image:, bucket: '')
    response = RestClient.post(
      'https://kland.smilebasicsource.com/uploadimage',
      {image: image, bucket: bucket}
    )
    if response =~ %r{http(s)?://kland.smilebasicsource.com/i/}
      return respsonse.gsub('http://', 'https://')
    else
      raise Error.new(response)
    end
  end

  def self.list(bucket: '', page: 1, per_page: 20)
    # get image list
  end

  # generic error class
  class Error < StandardError
    attr_reader :message
    
    def initialize(msg)
      @message = msg
    end
  end
end
