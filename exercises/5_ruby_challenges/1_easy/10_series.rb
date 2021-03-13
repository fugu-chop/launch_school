# 10) Write a program that will take a string of digits and return all the possible consecutive number series of a specified length in that string.
=begin
For example, the string "01234" has the following 3-digit series:
  012
  123
  234

Likewise, here are the 4-digit series:
  0123
  1234

Finally, if you ask for a 6-digit series from a 5-digit string, you should throw an error.
=end
class Series
  def initialize(num_str)
    @num_str = num_str
  end

  def slices(size)
    raise ArgumentError.new if size > @num_str.size

    convert_string_to_num.each_cons(size).map do |slice|
      slice
    end
  end

  def convert_string_to_num
    @num_str.chars.map(&:to_i)
  end
end
