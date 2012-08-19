require 'rspec'
require 'resolv'

require 'macros/zones_macro'

RSpec.configure do |config|
  config.tty = true
  config.include ZonesMacro
end

class Resolv::DNS::Resource
  def value
    %w(address data exchange name target).collect do |key|
      self.send(key.to_sym).to_s.upcase if self.respond_to?(key.to_sym)
    end.compact
  end

  def type
    self.class.name.split('::').last.upcase
  end
end