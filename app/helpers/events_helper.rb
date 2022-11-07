module EventsHelper
  def formatted_date(date, time)
    date.strftime("%a. %b %-d %Y") + time.strftime(" at %l:%M %P")
  end

  def time_to_event(start_date)
    current = Date.today
    return "Starts in: #{distance_of_time_in_words(current, start_date)}" if start_date > current
    "Event ended: #{time_ago_in_words(start_date)} ago"
  end
end