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

    # Refactor these!

    # Minute check
    if minutes + @minute > 59
      hours += (minutes + @minute).divmod(60).first
      minutes += (minutes + @minute).divmod(60).last
    end
    @minute += minutes

    # Day check
    if hours + @hour > 23
      days, additional_hours = hours.divmod(24)
      @hour += additional_hours 
    else
      @hour += hours
    end
    
    # Manually override day overflow
    @hour >= 24 ? @hour -= 24 : @hour

    # Need to return a string output as a result
    self.to_s
  end

  def -(minutes)
  end

  def ==(clock)
    self.to_s == clock.to_s
  end
end
