# 6) Create a custom set type.  For this problem, you're expected to implement your own custom set type. For simplicity, you may assume that all elements of a set must be numbers.
class CustomSet
  def initialize(arr = [])
    @set = arr
  end

  def empty?
    @set.empty?
  end

  def contains?(element)
    @set.include?(element)
  end

  def subset?(larger_set)
    @set.all? { |item| larger_set.set.include?(item) }
  end

  def disjoint?(other_set)
    @set.none? { |item| other_set.set.include?(item) }
  end

  def eql?(other_set)
    @set.uniq.sort == other_set.set.uniq.sort
  end

  def add(element)
    @set << element
    @set.uniq!
    self
  end

  def intersection(other_set)
    common_elements = @set.select { |element| other_set.set.include?(element) }
    CustomSet.new(common_elements)
  end

  def difference(other_set)
    uniq_elements = @set.reject { |element| other_set.set.include?(element) }
    CustomSet.new(uniq_elements)
  end

  def union(other_set)
    combined = @set + other_set.set
    CustomSet.new(combined.uniq.sort)
  end

  def ==(other)
    @set == other.set
  end

  protected

  attr_reader :set
end
