# 4) Write a program that takes a word and a list of possible anagrams and selects the correct sublist that contains the anagrams of the word.
class Anagram
  def initialize(initial_str)
    @initial_str = initial_str
  end

  def match(arr)
    anagrams = []
    arr.each do |word| 
      anagrams << word if anagrams?(@initial_str, word) && not_same?(@initial_str, word)
    end
    anagrams
  end

  private

  def anagrams?(word1, word2)
    word1.downcase.chars.sort == word2.downcase.chars.sort
  end

  def not_same?(word1, word2)
    word1.downcase != word2.downcase
  end
end
