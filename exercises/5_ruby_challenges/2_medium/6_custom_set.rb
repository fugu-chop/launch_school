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

  def subset?(new_set)
    # Need to check if @set contains the elements in the set, where set is a CustomSet object (new_set.set as a protected method)
  end

  def disjoint?(set)
  end

  def eql?(set)
  end

  def add?(element)
  end

  def intersection(set)
  end

  def difference(set)
  end

  def union(set)
  end

  protected

  attr_reader: set
end
