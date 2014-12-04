require 'holidays'
require 'holidays/us'

module TicketsHelper

  def business_time(datetime)
    day = datetime.strftime("%A")
    hour = datetime.strftime("%H").to_i

    if (day == "Sunday") or (day == "Saturday") or (hour >= 18) or (hour < 8)
      make_business(datetime, day, hour)
    else
      datetime
    end
  end

  def make_business(datetime, day, hour)

    addtl_days = 0.days

    if day == "Saturday"
      addtl_days = 2.days
    elsif day == "Sunday"
      addtl_days = 1.day
    elsif hour >= 18
      if day == "Friday"
        addtl_days = 3.days
      else
        addtl_days = 1.day
      end
    end

    adj_start(datetime, addtl_days)

  end

  def adj_start(datetime, more_days)
    (datetime+more_days).beginning_of_day + 8.hours
  end

  def closing_time(open, close)
    days = how_many_days(open, close)
    subtract_this = 0
    days.times do |i|
      next_day = (open+i.days).strftime("%A")
      if next_day == "Saturday" or next_day == "Sunday"
        subtract_this += 24.hours
      else
        subtract_this += 14.hours
      end
    end
    difference_between(open, close, subtract_this)
  end

  def how_many_days(open, close)
    ((close.beginning_of_day - open.beginning_of_day) / 60 / 60 / 24).to_i
  end

  def difference_between(open, close, subtract_this)
    diff = close - open - subtract_this
    if diff > 0
      diff.to_i / 60
    else
      0
    end
  end

end
