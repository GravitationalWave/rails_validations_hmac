require 'active_model'

module ActiveModel
  module Validations
    class HmacValidator < EachValidator

      DEFAULT_ALGORITHM = :sha1

      def validate_each(record, attribute, hmac)
        raise ArgumentError, "Definition :key is missing" unless options.has_key?(:key)
        raise ArgumentError, "Definition :data is missing" unless options.has_key?(:data)

        key       = value_in_context(record, options[:key])
        data      = value_in_context(record, options[:data])
        algorithm = value_in_context(record, options[:algorithm]) || DEFAULT_ALGORITHM
        message   = options[:message] or 'HMAC is not matching'

        if key and data and algorithm
          real_hmac = OpenSSL::HMAC.hexdigest("#{algorithm}", key, data)
          valid     = real_hmac == hmac
          record.errors.add(attribute, message) unless valid
        else
          record.errors.add(:hmac, 'Comparing key not found') unless key
          record.errors.add(:hmac, 'Comparing data not found') unless data
          record.errors.add(:hmac, 'Comparing algorithm not found') unless algorithm
          valid     = false
        end
      end

      private

      def value_in_context(record, evaluation)
        case evaluation
        when Symbol
          "#{evaluation}".split('.').inject(record) {|object, method| object.send(method) } rescue nil
        when Proc
          record.instance_exec(&evaluation) rescue nil
        when Array
          evaluation.collect {|e| value_in_context(record, e) }.join
        else
          evaluation
        end
      end


    end
  end
end
