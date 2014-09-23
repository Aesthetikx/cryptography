require_relative './encoder.rb'

module Cryptography
  module DES
    class Encryptor < Encoder

      def get_key(round)
        @key_schedule.keys[round - 1]
      end

      def encrypt(message)
        encode(message)
      end

    end
  end
end
