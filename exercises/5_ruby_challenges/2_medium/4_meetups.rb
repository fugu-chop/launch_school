# 4) Write a program that returns a Date object based on two inputs - a Day of the week and the incidence within the month (both case insensitive)
=begin
Descriptors can take the values ('first', 'second', 'third', 'fourth', 'fifth', 'last', 'teenth')
day can take ('Monday'..'Sunday') - case insensitive

April, June, September, and November have 30 days.
February has 28 in most years, but 29 in leap years.
All the other months have 31 days.
The first day of the week of the month (DOWM) is always between the 1st and 7th of the month.
The second DOWM is between the 8th and 14th of the month.
The third DOWM is between the 15th and 21st of the month.
The fourth DOWM is between the 22nd and 28th of the month.
The fifth DOWM is between the 29th and 31st of the month.
The last DOWM is between the 22nd and the 31st of the month depending on the number of days in the month.

You can determine the last day of the month by using the Date class by passing a day argument of -1 to the Date.civil method to create a Date object that represents the last day of the indicated year and month. 
=end
require 'date'

class Meetup
  DATE_RANGES = { 'first' => (1..7),
                 'second' => (8..14),
                 'third' => (15..21),
                 'fourth' => (22..28),
                 'fifth' => (29..31),
                 'last' => (22..31),
                 'teenth' => (13..19) }

  DAY_INDEX = %w(sunday monday tuesday wednesday thursday friday saturday).zip((0..6).to_a).to_h

  # This should control what year and month we're looking up for our day and incidence
  def initialize(year, month)
    @year = year
    @month = month
  end

  def day(day, incidence)
    day = day.downcase
    incidence = incidence.downcase
    day_range =  DATE_RANGES[incidence]
    date_objects = validate_days(day_range)
    week_day = calculate_weekday(date_objects, day)

    # Return nil if the day doesn't exist
    return nil if week_day.empty?

    # Return the last object, as there might be multiple instances of a day in 'last'
    week_day = week_day.last.day

    Date.civil(@year, @month, week_day)
  end

  private

  def validate_days(day_range)
    day_range.map do |day|
      Date.valid_date?(@year, @month, day) ? Date.civil(@year, @month, day) : next
    end
  end

  def calculate_weekday(dates, day)
    # next will return nils, but compact can deal with this
    dates.compact.select do |date_object|
      date_object.wday == DAY_INDEX[day]
    end
  end
end
