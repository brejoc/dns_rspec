module ZonesMacro
  module ClassMethods
    def expects(expected = {})
      matched_records = records.select do |record|
        record.type == expected[:type].upcase &&
                                    record.value.include?(expected[:value].upcase)
      end
      it "should have the correct DNS entry" do
        matched_records.should_not be_empty
      end
    end

    private
    def records
      @records ||= begin
        Timeout::timeout(1) {
          Resolv::DNS.new.getresources(self.display_name, Resolv::DNS::Resource::IN::ANY)
        }
      rescue Timeout::Error => e
        $stderr.puts "Connection timed out for #{self.display_name}"
        []
      end
    end
  end

  module InstanceMethods
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
end
