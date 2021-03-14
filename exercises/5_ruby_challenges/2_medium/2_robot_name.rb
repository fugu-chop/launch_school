# 1) Write a program that manages robot factory settings. The first time you boot them up, a random name is generated, such as RX837 or BC811. Every once in a while, we need to reset a robot to its factory settings, which means that their name gets wiped. The next time you ask, it will respond with a new random name.
=begin
Robot names should take the form /^[A-Z]{2}\d{3}$/ (Two capital letters followed by 3 digits)
=end
class Robot
  attr_reader :name, :reset
  # We don't want any instances sharing the same name
  @@previous_names = []

  def self.previous_names
    @@previous_names
  end

  def initialize
    reset
  end

  def reset
    # Delete the old name from @@previous_names since it's available to use again
    @@previous_names.delete(@name)
    loop do
      new_name = random_name
      if !@@previous_names.include?(new_name)
        @name = new_name
        @@previous_names << @name
      end
      break if @@previous_names.include?(@name)
    end
    @name
  end

  private

  def random_name
    robot_name = ''
    letters = ('A'..'Z').to_a
    numbers = ('0'..'9').to_a
    2.times { |_| robot_name << letters.sample }
    3.times { |_| robot_name << numbers.sample }
    robot_name
  end
end
