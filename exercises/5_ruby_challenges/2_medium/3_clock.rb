class Clock
  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute=0)
    # We can initialise a new object within the class method
    new(hour, minute)
  end

  def to_s
    # Each % represents a variable, 0 represents the string to be appended, 2 represents the total number of digits
    format('%02d:%02d', @hour, @minute)
  end

  def +(add_minutes)
    hours, minutes = add_minutes.divmod(60)

    # Minute check
    add_minute_helper(hours, minutes)

    # Day check
    add_day_helper(hours)
    
    # Manually override day overflow. Due to the day check, we don't ever need to deal with numbers > 47
    @hour >= 24 ? @hour -= 24 : @hour

    # Need to return the object as a result
    self
  end

  def -(minus_minutes)
    # Input is a positive integer     
    hours, minutes = minus_minutes.divmod(60)

    # Minute check - For some reason, if I extract this to a method, it no longer works
    @minute -= minutes
    if @minute < 0
      # This logic is useful for hours, since it rounds down, but also handle edge case where @hour is 0 but minus_minutes still drags the hour down
      # It's not best practice to use divmod with negative integers, since the logic is hard to follow
      hours != 0 ? hours -= (@minute - minutes).divmod(60).first : hours += 1
      @minute += 60
    end

    # Day check
    subtract_day_helper(hours)

    @hour < 0 ? @hour += 24 : @hour

    self
  end

  def ==(clock)
    self.to_s == clock.to_s
  end

  private

  def add_minute_helper(hours, minutes)
    if minutes + @minute > 59
      hours += (minutes + @minute).divmod(60).first
      minutes += (minutes + @minute).divmod(60).last
    end
    @minute += minutes
  end

  def add_day_helper(hours)
    if hours + @hour > 23
      days, additional_hours = hours.divmod(24)
      @hour += additional_hours
    else
      @hour += hours
    end
  end

  def subtract_day_helper(hours)
    if @hour - hours < 0
      days, additional_hours = hours.divmod(24)
      @hour -= additional_hours
    else
      @hour -= hours
    end
  end
end

# Elegant solution
=begin
class Clock
  MINS_IN_HOUR = 60
  MINS_IN_DAY = 1440

  def initialize(total)
    convert_time(total)
  end

  def convert_time(total)
    @total = total
    # Removes the impact of days - you now have minutes effective within a 24 hour window
    @total %= MINS_IN_DAY
    @hours, @minutes = @total.divmod(MINS_IN_HOUR)
  end

  # We can define a custom definition of the explicit self
  def self
    # Return instance variable instead of calling object
    @total
  end

  def self.at(hours, minutes = 0)
    total = (hours * MINS_IN_HOUR) + minutes
    new(total)
  end

  def to_s
    convert_time(@total)
    format('%02d:%02d', @hours, @minutes)
  end

  def +(other)
    @total += other
    self
  end

  def -(other)
    @total -= other
    self
  end

  def ==(other)
    to_s == other.to_s
  end
end
=end
