# From Quiz 4 #
* The following is a short description of a meal ordering application:
    * The application lets a customer place an order for a meal.
    * A meal always has three meal items: a burger, a side, and drink.
    * For each meal item, the customer must choose an option.
    * The application must compute the total cost of the order.
* Identify the verbs and nouns that are relevant to the design of the program
    - Nouns: Meal, customer, option, items, cost, order
    - Verbs: Place order, choose, compute
* Create an outline in code (spike) of the structure of this application.
    ```ruby
    class Customer
    end
    
    class Order
    end

    class Item
    end

    class Burger < Item
      OPTIONS = {
        '1' => { name: 'LS Burger', cost: 3.00 },
        '2' => { name: 'LS Cheeseburger', cost: 3.50 },
        '3' => { name: 'LS Chicken Burger', cost: 4.50 },
        '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
      }
    end

    class Side < Item
      OPTIONS = {
        '1' => { name: 'Fries', cost: 0.99 },
        '2' => { name: 'Onion Rings', cost: 1.50 }
      }
    end

    class Drink < Item
      OPTIONS = {
        '1' => { name: 'Cola', cost: 1.50 },
        '2' => { name: 'Lemonade', cost: 1.50 },
        '3' => { name: 'Vanilla Shake', cost: 2.00 },
        '4' => { name: 'Chocolate Shake', cost: 2.00 },
        '5' => { name: 'Strawberry Shake', cost: 2.00 }
      }
    end
    ```
* Place methods in the appropriate classes to correspond with various verbs.
    ```ruby
    class Customer
      def place_order
        @order = Order.new
      end
    end
    
    class Order
      def initialize
        @burger = Burger.new
        @side = Side.new
        @drink = Drink.new
      end

      def meal
        [@burger, @side, @drink]
      end

      def total
        total_cost = @burger.cost + @side.cost + @drink.cost
        format("$%.2f", total_cost) # #format formats the cost to two decimal places
      end

      def to_s
        meal.map(&:to_s).join(', ')
      end
    end

    class Item
      def initialize
        @option = choose_option
      end

      def choose_option
        puts "Please choose a #{self.class} option:"
        puts item_options # item_options returns a list of options and prices for a particular item type
        gets.chomp
      end

      # Add a cost method to the MealItem class. This method would return the appropriate cost value from an OPTIONS hash.
      def cost
        self.class::OPTIONS[@option][:cost]
      end

      def to_s
        self.class::OPTIONS[@option][:name]
      end
    end
    
    class Burger < Item
      OPTIONS = {
        '1' => { name: 'LS Burger', cost: 3.00 },
        '2' => { name: 'LS Cheeseburger', cost: 3.50 },
        '3' => { name: 'LS Chicken Burger', cost: 4.50 },
        '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
      }
    end

    class Side < Item
      OPTIONS = {
        '1' => { name: 'Fries', cost: 0.99 },
        '2' => { name: 'Onion Rings', cost: 1.50 }
      }
    end

    class Drink < Item
      OPTIONS = {
        '1' => { name: 'Cola', cost: 1.50 },
        '2' => { name: 'Lemonade', cost: 1.50 },
        '3' => { name: 'Vanilla Shake', cost: 2.00 },
        '4' => { name: 'Chocolate Shake', cost: 2.00 },
        '5' => { name: 'Strawberry Shake', cost: 2.00 }
      }
    end
    ```
