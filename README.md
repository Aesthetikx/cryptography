ovaltine
============

Simple cryptography utilities in ruby

```ruby
require 'cryptography'
```

###Playfair Cipher

```ruby
pf = Cryptography::Playfair.new("passcode")

puts pf
# [ p  a  s  c  o ]
# [ d  e  b  f  g ]
# [ h  ij  k  l  m ]
# [ n  q  r  t  u ]
# [ v  w  x  y  z ]

ciphertext = pf.encode "The last Metroid is in captivity. The galaxy is at peace..."
# => "nlfijsculfqushekahqoscnhwlqcyijdeoijcyzkacqadsobw"

passcode = pf.decode ciphertext
# => "thelastmetroidisincaptivitythegalaxyisatpeacex"
```

###Frequency Analysis

Helpful methods mixed into String

```ruby
# Sample text
text = "Jerry was a race car driver".downcase.gsub(/\s/,'')
```

Find the letter frequency of a text:
```ruby
text.letter_frequency
# => {"j"=>1, "e"=>3, "r"=>6, "y"=>1, "w"=>1, "a"=>4, "s"=>1, ...
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

###Co-prime numbers
Generate the co-primes (< 26) of 26
```ruby
26.coprimes
# => [1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 23, 25]
```

###DES
Cryptographically insecure Data Encryption Standard implementation
####Key Schedule
Generate the 8th round subkey:
```ruby
Cryptography::DES::KeySchedule.new("133457799BBCDFF1").keys[7]
# => "111101111000101000111010110000010011101111111011"
```

### Toy Tetragraph Hash
Simple toy hash implementation
```ruby
Cryptography::TTH.hash("I leave twenty million dollars to my friendly cousin Bill.")
# => "BFQG"

Cryptography::TTH.hash("AYHGD")
# => "BFQG"
```
