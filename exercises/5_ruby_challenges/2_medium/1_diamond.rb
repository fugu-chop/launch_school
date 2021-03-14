# 1) The diamond exercise takes as its input a letter, and outputs it in a diamond shape. Given a letter, it prints a diamond starting with 'A', with the supplied letter at the widest point.
=begin
The first row contains one 'A'.
The last row contains one 'A'.
All rows, except the first and last, have exactly two identical letters.
The diamond is horizontally symmetric.
The diamond is vertically symmetric.
The diamond has a square shape (width equals height).
The letters form a diamond shape.
The top half has the letters in ascending order.
The bottom half has the letters in descending order.
The four corners (containing the spaces) are triangles.

Diamond for letter 'A':
A

Diamond for letter 'B':
 A
B B
 A

Diamond for letter 'C':
  A
 B B
C   C
 B B
  A

Diamond for letter 'D':
   A
  B B
 C   C
D     D
 C   C
  B B
   A

Diamond for letter 'E':
    A
   B B
  C   C
 D     D
E       E
 D     D
  C   C
   B B
    A
=end
class Diamond
  CHAR_MAP = (1..26).zip('A'..'Z').to_h

  def self.make_diamond(letter)
    return "A\n" if letter == 'A'

    letter_sequence = ('A'..letter).to_a
    # 'B' is a weird edge case we have to hardcode for
    max_width = letter == 'B' ? 3 : letter_sequence.size * 2 - 1
    
    top_half = (2..letter_sequence.index(letter) + 1).map do |position| 
      # The center method allows us to pad a string with spaces according to a max width
      (CHAR_MAP[position] + ' ' * calculate_spaces(position) + CHAR_MAP[position]).center(max_width)
    end
    # We don't have to recalculate the above for the lower half, just reverse a subset of the array
    bottom_half = top_half.reverse[1..-1]
    mid_rows = (top_half << bottom_half).flatten
    
    # Have to add an additional newline as join doesn't add one after the last element
    # We don't need to use explicit self to call class methods
    end_rows(max_width) + mid_rows.join("\n") + "\n" + end_rows(max_width)
  end

  def self.end_rows(max_width)
    'A'.center(max_width) + "\n"
  end

  def self.calculate_spaces(position)
    position * 2 - 3
  end

  # We can use this to make class methods private. We have to place this after our class method definitions
  private_class_method :end_rows, :calculate_spaces
end
