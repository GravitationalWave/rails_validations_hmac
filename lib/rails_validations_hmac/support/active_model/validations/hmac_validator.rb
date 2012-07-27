require 'active_model'

module ActiveModel
  module Validations
    class HmacValidator < EachValidator

      DEFAULT_ALGORITHM = :sha1

      def validate_each(record, attribute, hmac)
        key       = value_in_context(record, options[:key]) or raise ":key missing"
        data      = value_in_context(record, options[:data]) or raise ":data missing"
        algorithm = value_in_context(record, options[:algorithm]) || DEFAULT_ALGORITHM
        message   = options[:message] or 'HMAC is invalid'

        real_hmac = OpenSSL::HMAC.hexdigest("#{algorithm}", key, data)

        valid     = real_hmac == hmac
        record.errors.add(attribute, message) unless valid
      end

      private

      def value_in_context(record, evaluation)
        case evaluation
        when Symbol
          "#{evaluation}".split('.').inject(record) {|object, method| object.send(method) }
        when Proc
          record.instance_exec(&evaluation)
        when Array
          evaluation.collect {|e| value_in_context(record, e) }.join
        else
          evaluation
        end
      end


    end
  end
end
