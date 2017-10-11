require "klandimage/version"
require 'rest-client'
require 'json'

# This module contains all the request methods
module KlandImage
  # [Integer] Specify you want all images in the bucket.
  ALL = -1

  # Upload an image to kland.
  #
  # @param image [File] An image file to upload.
  # @param bucket [String] The bucket to upload to.
  # 
  # @return [String] The URL of the uploaded image.
  # 
  # @raise [RuntimeError] if the POST response is not a URL.
  def self.upload(image:, bucket: '')
    response = RestClient.post(
      'https://kland.smilebasicsource.com/uploadimage',
      {image: image, bucket: bucket}
    )
    
    if response =~ %r{http(s)?://kland.smilebasicsource.com/i/}
      return respsonse.gsub('http://', 'https://')
    else
      raise response
    end
  end

  # Get a page of images from a bucket.
  #
  # @param bucket [String] The name of the bucket to check.
  # @param page [Integer] The page of results to get.
  #   This value doesn't matter if ipp is KlandImage::ALL (-1).
  # @param ipp [Integer] Images per page.
  #   The number of images retrieved will never be greater
  #   than this value, unless using KlandImage::ALL (-1),
  #   in which case all images in the bucket will be returned
  #   regardless of page number.
  # 
  # @return [Hash{Symbol => String, Integer, Array}]
  #   A Hash containing information about the
  #   request, and the page of images you requested.
  def self.list(bucket: '', page: 1, ipp: 20)
    response = RestClient.get(
      'https://kland/smilebasicsource.com/image',
      {bucket: bucket, page: page, ipp: ipp, asJSON: true}
    )

    obj = JSON.parse(response, symbolize_keys: true)

    return obj
  end
end
