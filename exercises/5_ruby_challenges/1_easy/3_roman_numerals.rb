# 3) Write a program that converts Arabic numerals to Roman Numerals. There is no need to convert numbers above 3000; the Romans themselves didn't tend to go any higher.

class RomanNumeral
  # We also define instances where there would be 4 of a kind (e.g. IIII, XXXX, CCCC)
  ROMAN_NUMERALS = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  def initialize(number)
    @number = number
  end

  def to_roman
    roman_version = ''
    # We defined a private getter method so we could reference a return version of this number without editing the state directly
    to_convert = number
    quantities = ROMAN_NUMERALS.keys.sort.reverse

    # Iterate through each of the values, essentially filtering to the largest possible gate that is still divisible
    quantities.each do |value|
      # divmod is how we can keep track of two integers simultaneously, without having to track the specific place in the number
      multiplier, remainder = to_convert.divmod(value)
      # Append Roman Numeral * how many times it occurs. I have altered the solution so it doesn't rely on the order of a hash (which in older versions of Ruby, is unreliable)
      roman_version += (ROMAN_NUMERALS[value] * multiplier) if multiplier > 0
      # Update the remainder so that it removes the part of the number that's been captured - 1000 in our case.
      to_convert = remainder
    end
    roman_version
  end

  private

  attr_accessor :number
end
