class Clock
  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute=0)
    new(hour, minute)
  end

  def to_s
  end

  def +(minutes)
  end

  def -(minutes)
  end

  def ==(clock)
  end
end
