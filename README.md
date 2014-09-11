cryptography
============

Simple cryptography utilities in ruby

###Frequency Analysis

Helpful methods mixed into String

```ruby
require 'cryptography'

# Sample text
text = "Jerry was a race car driver".downcase.gsub(/\s/,'')
```

Find the letter frequency of a text:
```ruby
text.letter_frequency
# => {"j"=>1, "e"=>3, "r"=>6, "y"=>1, "w"=>1, "a"=>4, "s"=>1, "c"=>2, "d"=>1, "i"=>1, "v"=>1}
```

Find the three most frequent digrams:
```ruby
text.digram_frequency.sort_by { |digram, frequency| frequency}.reverse.take(3)
# => [["er", 2], ["ar", 2], ["ra", 1]]
```

Other available methods:
```ruby
text.trigram_frequency
text.ngram_frequency(8)
```
