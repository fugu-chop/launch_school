# 5) Write a program that, given a word, computes the Scrabble score for that word.
class Scrabble
  SCORE_HASH = { 'AEIOULNRST' => 1,
                 'DG' => 2,
                 'BCMP' => 3,
                 'FHVWY' => 4,
                 'K' => 5,
                 'JX' => 8,
                 'QZ' => 10
  }

  def self.score(word)
    # We can instantiate an object in a class method
    Scrabble.new(word).score
  end

  def initialize(word)
    @word = word
  end

  def score
    score = 0
    return score if @word.nil?

    @word.upcase.chars.each do |letter|
      SCORE_HASH.keys.each do |key|
        score += SCORE_HASH[key] if key.include?(letter)
      end
    end

    score
  end
end
