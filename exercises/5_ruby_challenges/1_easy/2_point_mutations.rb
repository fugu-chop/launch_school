# 2) Write a program that can calculate the Hamming distance between two DNA strands.
=begin
GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT
^ ^ ^  ^ ^    ^^

The Hamming distance between these two DNA strands is 7. If you have two sequences of unequal length, you should compute the Hamming distance over the shorter length.
=end
class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other_strand)
    idx = 0
    counter = 0
    until idx >= other_strand.size || idx >= @strand.size
      counter += 1 if other_strand[idx] != @strand[idx]
      idx += 1
    end
    counter
  end
end