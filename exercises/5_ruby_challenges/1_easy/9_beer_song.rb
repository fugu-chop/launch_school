# 9) Write a program that can generate the lyrics of the 99 Bottles of Beer song.
class BeerSong
  def self.verse(*verse)
    self.verses(*verse)
  end

  def self.verses(*verses)
    verses = (verses.max).downto(verses.min).to_a
    verses.map do |verse|
      quantity = verse == 1 ? "bottle" : "bottles"
      removed = verse == 1 ? "it" : "one"
      reduced_bottles = verse == 1 ? "no more" : verse - 1
      reduced_quantity = verse == 2 ? "bottle" : "bottles"

      verse > 0 ? "#{verse} #{quantity} of beer on the wall, #{verse} #{quantity} of beer.\nTake #{removed} down and pass it around, #{reduced_bottles} #{reduced_quantity} of beer on the wall.\n" :
      "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
    end.join("\n")
  end

  def self.lyrics
    self.verses(99,0)
  end
end
