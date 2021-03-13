# 7) Implement octal to decimal conversion. Given an octal input string, your program should produce a decimal output. Treat invalid input as octal 0. Note: Implement the conversion yourself. 
=begin
  233 # octal
= 2*8^2 + 3*8^1 + 3*8^0
= 2*64  + 3*8   + 3*1
= 128   + 24    + 3
= 155

  # Octal to decimal
  17
= 10 + 7
= 1 * 8^1 + 7 * 8^0
= 15

  # Invalid test case (Octal numbers use the digits 0 to 7)
  9
= 9 * 8^0
=end
class Octal
  def initialize(octal_num)
    @octal_num = octal_num
  end

  def to_decimal
    return 0 if !('0'..'9').include?(@octal_num[-1]) || @octal_num[-1] >= '8'
    digit_arr = @octal_num.chars.map(&:to_i)
  end
end