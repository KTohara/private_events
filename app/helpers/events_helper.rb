module EventsHelper
  def formatted_date(date, time)
    date.strftime("%a. %b %-d %Y") + time.strftime(" at %l:%M %P")
  end

  def time_to_event(start_date, end_date)
    current = Time.zone.now
    if start_date > current
      "Starts in: #{distance_of_time_in_words(current, start_date)}"
    elsif current.between?(start_date, end_date)
      "Event is currently live!"
    else
      "Event ended: #{time_ago_in_words(start_date)} ago"
    end
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