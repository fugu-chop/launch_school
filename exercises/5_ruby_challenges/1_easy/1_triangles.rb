# 1) Write a program to determine whether a triangle is equilateral, isosceles, or scalene. 
=begin
An equilateral triangle has all three sides the same length. An isosceles triangle has exactly two sides of the same length. A scalene triangle has all sides of different lengths. Note: For a shape to be a triangle at all, all sides must be of length > 0, and the sum of the lengths of any two sides must be greater than or equal to the length of the third side.
=end
class Triangle
  def initialize(a, b, c)
    @min, @mid, @max = [a, b, c].sort
    raise ArgumentError.new('Invalid triangle') if invalid?
  end

  def kind
    if [@min, @mid, @max].uniq.size == 1
      'equilateral'
    elsif [@min, @mid, @max].uniq.size == 3
      'scalene'
    else
      'isosceles'
    end
  end

  private

  def invalid?
    [@min, @mid, @max].any? { |side| side <= 0 } || (@min + @mid) < @max
  end
end
