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
  DATE_RANGES = { 'first' => (1..7).to_a,
                 'second' => (8..14).to_a,
                 'third' => (15..21).to_a,
                 'fourth' => (22..28).to_a,
                 'fifth' => (29..31).to_a,
                 'last' => (22..31).to_a,
                 'teenth' => (13..19).to_a }

  DAY_INDEX = %w(sunday monday tuesday wednesday thursday friday saturday).zip((0..6).to_a).to_h

  # This should control what year and month we're looking up for our day and incidence
  def initialize(year, month)
    @year = year
    @month = month
  end

  def day(day, incidence)
    # @year = 2015
    # @month = 8
    # day = 'Monday'
    # incidence = 'fifth'
    day = day.downcase
    incidence = incidence.downcase

    # Need to account for Feb as well
    # Return nil where date doesn't exist
    day_range =  DATE_RANGES[incidence]
    day_range.pop if [4, 6, 9, 11].include?(@month) && (incidence == 'fifth' || incidence == 'last')

    date_objs = day_range.map do |day|
      Date.civil(@year, @month, day)
    end

    week_day = date_objs.select do |obj|
      obj.wday == DAY_INDEX[day]
    end.first.day

    Date.civil(@year, @month, week_day)
  end
end

=begin
Algo
  Capture ranges of DOWM in a hash - with the keys as the descriptors, values as the day range (array?)
  We can then create an array of potential dates
  We then iterate through this array of dates, checking for the day 
    The .wday method on a date object returns 0-6, where 0 is sunday
  We return that date as an integer, then return a Date object using the .civil method
  
=end