# 1) Modify the provided class so that any access to data must result in a log entry being generated. That is, any call to the class which will result in data being returned must first call a logging class. Assume that you can modify the initialize method in SecretFile to have an instance of SecurityLogger be passed in as an additional argument. 
=begin
class SecretFile
  attr_reader :data

  def initialize(secret_data)
    @data = secret_data
  end
end

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end
=end
class SecretFile
  def initialize(secret_data)
    @data = secret_data
    @logger = SecurityLogger.new
  end

  def data
    # We remove the attr_reader method as that allows 'unlogged' read access to the @data instance variable.
    @logger.create_log_entry
    @data
  end
end

# 2) Catamarans don't have tires. But we still want common code to track fuel efficiency and range. Modify the class definitions and move code into a Module, as necessary, to share code among the Catamaran and the wheeled vehicles.
=begin
class WheeledVehicle
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
  end
end
=end
module Moveable
  attr_accessor :speed, :heading
  # While we don't actually have any direct setter functionality for these instance variables, this is only place the solution uses those two attributes is in the Movable module, so you want to have the Movable module to have control over setting them - think of this as encapsulation. 
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    # We can also use @fuel_* instance variables, but since we defined the setter methods in the Moveable module, we should use them
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Moveable

  attr_reader :propeller_count, :hull_count
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
end

# 3) Building on the prior vehicles question, we now must also track a basic motorboat. A motorboat has a single propeller and hull, but otherwise behaves similar to a catamaran. Therefore, creators of Motorboat instances don't need to specify number of hulls or propellers. How would you modify the vehicles code to incorporate a new Motorboat class?
module Moveable
  attr_accessor :speed, :heading
  # While we don't actually have any direct setter functionality for these instance variables, this is only place the solution uses those two attributes is in the Movable module, so you want to have the Movable module to have control over setting them - think of this as encapsulation. 
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class SeaVessel
  include Moveable

  attr_reader :propeller_count, :hull_count
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    # Defined in the Moveable module
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
end

class Catamaran < SeaVessel
end

class Motorboat < SeaVessel
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # This is equivalent to calling super(num_propellers = 1, num_hulls = 1, km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

# 4) The designers of the vehicle management system now want to make an adjustment for how the range of vehicles is calculated. For the seaborne vehicles, due to prevailing ocean currents, they want to add an additional 10km of range even if the vehicle is out of fuel. Alter the code related to vehicles so that the range for autos and motorcycles is still calculated as before, but for catamarans and motorboats, the range method will return an additional 10km.
class SeaVessel
  include Moveable

  attr_reader :propeller_count, :hull_count
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = fuel_capacity
  end

  def range
    super() + 10
  end
end
