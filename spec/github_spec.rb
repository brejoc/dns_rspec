require_relative 'spec_helper'

describe 'github.com' do
  expects type: 'A', value: '207.97.227.239'
end

describe 'www.github.com' do
  expects type: 'A', value: '207.97.227.243'
end
