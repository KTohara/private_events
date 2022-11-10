module EventsHelper
  def formatted_date(date, time)
    date.strftime("%a. %b %-d %Y") + time.strftime(" at %l:%M %P")
  end

  def time_to_event(start_date)
    current = Date.today
    return "Starts in: #{distance_of_time_in_words(current, start_date)}" if start_date > current
    "Event ended: #{time_ago_in_words(start_date)} ago"
  end

  def invitation_status(status)
    case status
    when 'unconfirmed'
      content_tag :div, class: "badge bg-warning text-black col-auto" do 
        'Awaiting'
      end
    when 'accepted'
      content_tag :div, class: "badge bg-success text-light col-auto" do
        'Joined'
      end
    when 'declined'
      content_tag :div, class: "badge bg-danger text-white col-auto" do 
        'Declined'
      end
    end
  end
end