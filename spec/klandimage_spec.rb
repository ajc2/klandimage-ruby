require 'spec_helper'

describe KlandImage do
  it 'has a version number' do
    expect(KlandImage::VERSION).not_to be nil
  end

  it 'gets image lists' do
    response = KlandImage.list(bucket: 'snail_screen', ipp: 5)
    expect(response[:bucket]).to eq('snail_screen')
    expect(response[:page]).to eq(1)
    expect(response[:ipp]).to eq(5)
    expect(response[:images].size).to eq(5)
  end
end
