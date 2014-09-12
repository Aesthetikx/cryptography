module Cryptography
  class Playfair

    def initialize(keyword)
      @arr = []
      keyword.downcase.gsub(/\s/,'').chars.uniq.map { |l| make_ij(l) }.compact.each { |l| @arr << l }
      ('a'..'z').to_a.map { |l| make_ij(l) }.compact.each do |l|
        unless @arr.include? l
          @arr << l
        end
      end
    end

    def to_s
      s = ""
      (0...5).each do |y|
        s << "["
        (0...5).each do |x|
          s << " #{char_at(x, y)} "
        end
        s << "]\n"
      end
      s
    end

    def encode(message)
      message = x_pad(message.downcase.gsub(/\s/,''))
      puts message
      ciphertext = ""
      message.chars.each_slice(2) do |pair|
        x1 = find_char(pair[0])[0]
        y1 = find_char(pair[0])[1]
        x2 = find_char(pair[1])[0]
        y2 = find_char(pair[1])[1]

        if x1 != x2 && y1 != y2
          # Rectangle
          x3 = x2
          y3 = y1
          x4 = x1
          y4 = y2
        elsif x1 == x2
          # Column
          x3 = x1
          y3 = (y1 + 1) % 5
          x4 = x2
          y4 = (y2 + 1) % 5
        elsif y1 == y2
          # Row
          x3 = (x1 + 1) % 5
          y3 = y1
          x4 = (x2 + 1) % 5
          y4 = y2
        end

        a = char_at(x3, y3)
        b = char_at(x4, y4)

        ciphertext << a << b
      end
      ciphertext
    end

    def decode(ciphertext)
      message = ""
      ciphertext.downcase.chars.each_slice(2) do |pair|
        x1 = find_char(pair[0])[0]
        y1 = find_char(pair[0])[1]
        x2 = find_char(pair[1])[0]
        y2 = find_char(pair[1])[1]

        if x1 != x2 && y1 != y2
          # Rectangle
          x3 = x2
          y3 = y1
          x4 = x1
          y4 = y2
        elsif x1 == x2
          # Column
          x3 = x2
          y3 = (5 + y1 - 1) % 5
          x4 = x1
          y4 = (5 + y2 - 1) % 5
        elsif y1 == y2
          # Row
          x3 = (5 + x1 - 1) % 5
          y3 = y2
          x4 = (5 + x2 - 1) % 5
          y4 = y1
        end

        a = char_at(x3, y3)
        b = char_at(x4, y4)

        message << a << b
      end
      message.gsub('ij', 'i')
    end


    private

    def find_char(char)
      char = char.gsub(/[ij]/,'ij')
      i = @arr.index(char)
      [i % 5, i / 5]
    end

    def char_at(x, y)
      @arr[y * 5 + x]
    end

    def make_ij(char)
      case char
      when "i"
        "ij"
      when "j"
        nil
      else
        char
      end
    end

    def x_pad(message)
      padded = []
      message.chars.each do |c|
        if padded.length.odd? and padded.last == c
          padded << "x"
        end
        padded << c
      end
      padded << "x" unless padded.length.even?
      padded.join
    end

  end
end
