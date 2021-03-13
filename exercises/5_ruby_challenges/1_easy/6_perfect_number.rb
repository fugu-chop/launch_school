# 6) Write a program that can tell whether a number is perfect, abundant, or deficient.
=begin
Perfect numbers have an Aliquot sum that is equal to the original number.
Abundant numbers have an Aliquot sum that is greater than the original number.
Deficient numbers have an Aliquot sum that is less than the original number.

An aliquot sum is the sum of the number's divisors for which there is no remainder
=end
class PerfectNumber
  def self.classify(num)
    raise StandardError.new if num < 1
    
    aliquot = (1...num).select { |divisor| num % divisor == 0 }.reduce(&:+)
    
    if aliquot == num
      'perfect'
    elsif aliquot > num
      'abundant'
    else
      'deficient'
    end
  end
end

# Suggested Answer
=begin
class PerfectNumber
  def self.classify(number)
    raise StandardError.new if number < 1
    sum = sum_of_factors(number)

    if sum == number
      'perfect'
    elsif sum > number
      'abundant'
    else
      'deficient'
    end
  end

  # We generally can't make class methods private, and we aren't able to reference instance methods in a class method as they require an object to be instantiated.
  # However, using the class << self idiom lets us operate on the class itself as an object.
  # By adding a private instance method to the class object, we effectively create a private class method. Why this works isn't important at this stage, but it's a useful idiom to know.
  
  class << self
    private

    def sum_of_factors(number)
      (1...number).select do |possible_divisor|
        number % possible_divisor == 0
      end.sum
    end
  end
end
=end