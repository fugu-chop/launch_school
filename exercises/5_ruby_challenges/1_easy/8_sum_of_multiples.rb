# 8) Write a program that, given a natural number and a set of one or more other numbers, can find the sum of all the multiples of the numbers in the set that are less than the first number. If the set of numbers is not given, use a default set of 3 and 5.
=begin
For instance, if we list all the natural numbers up to, but not including, 20 that are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18. The sum of these multiples is 78.
=end
class SumOfMultiples
  def initialize(*factors)
    # The ternary operator returns a value, so we can set the instance variable outside
    @factors = factors.empty? ? [3, 5] : factors
  end

  def self.to(target)
    SumOfMultiples.new.to(target)
  end

  def to(target)
    # The three dot notation handles (1...1) by returning an empty array
    (1...target).select do |divider|
      valid_factor?(divider)
    end.sum
  end

  private

  def valid_factor?(divider)
    # any? stops iterating as soon as it finds a truthy return value from the block
    @factors.any? { |factor| divider % factor == 0 }
  end
end
