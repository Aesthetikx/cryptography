module Ovaltine
  module Prime
    def coprimes
      (0...self).to_a.select { |n| self.gcd(n) == 1 }
    end
  end
end

class Fixnum
  include Ovaltine::Prime
end
