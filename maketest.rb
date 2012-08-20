# `config` is the existing DNS configuration file
config = File.readlines('config.txt').

# For each line, split on a space, remove the drunk, and
# create a hash for easy access.
collect do |line|
  split = line.split(' ').collect{ |l| l.strip.chomp('.') }
  { :url => split[0], :ttl => split[1], :type => split[3], :data => split[4] }
end

# For each record, write out the spec and expected results.
# I had to massage some data using `gsub` because of inconsistent formatting.
config.each do |record|
  str = <<-EOH
require 'spec_helper'

describe '#{record[:url]}' do
  expects type: 'CNAME', value: 'reverse-2.example.com'
end
EOH

  # Write the spec to the proper file
  File.open("spec/units/#{record[:url]}_spec.rb", 'w'){ |f| f.write(str) }
end
