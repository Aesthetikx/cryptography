module CharacterFrequency

  def ngram_frequency(n)
    freq = {}
    chars.each_cons(n).map do |a|
      ngram = a.join
      freq[ngram] ||= 0
      freq[ngram] += 1
    end
    freq
  end

  def letter_frequency
    ngram_frequency(1)
  end

  def digram_frequency
    ngram_frequency(2)
  end

  def trigram_frequency
    ngram_frequency(3)
  end

end

class String
  include CharacterFrequency
end
