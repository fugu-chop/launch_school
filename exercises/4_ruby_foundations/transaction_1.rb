class Transaction
  attr_reader :item_cost
  attr_accessor :amount_paid

  def initialize(item_cost)
    @item_cost = item_cost
    @amount_paid = 0
  end

  # We've added an input keyword parameter that lets the caller provide a different source of input. The default value for the parameter is $stdin; if we don't provide the input parameter, Ruby will use $stdin as its value.

  # What is $stdin? It represents the standard input stream, which is usually the keyboard. Specifically, $stdin is a global variable that Ruby uses to represent the default source of input. Thus, when we write code such as str = gets.chomp, it's equivalent to str = $stdin.gets.chomp.
  def prompt_for_payment(input: $stdin, output: $stdout)
    loop do
      # When set to a StringIO object, the output consumes the text generated from puts. We use this output mock object within our method, we call StringIO#puts and the string passed to puts gets stored within the StringIO object. It isn't output to the user.
      output.puts "You owe $#{item_cost}.\nHow much are you paying?"
      # The StringIO object provides a gets method here (instead of Kernel#gets). 
      @amount_paid = input.gets.chomp.to_f
      break if valid_payment? && sufficient_payment?
      output.puts "That is not the correct amount.\nPlease make sure to pay the full cost."
    end
  end

  private

  def valid_payment?
    amount_paid > 0.0
  end

  def sufficient_payment?
    amount_paid >= item_cost
  end
end
