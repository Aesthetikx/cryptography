require_relative './encoder.rb'

module Cryptography
  module DES
    class Decryptor < Encoder

      def get_key(round)
        @key_schedule.keys.reverse[round - 1]
      end

      def decrypt(message)
        encode(message)
      end

    end
  end
end
