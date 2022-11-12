module UsersHelper
  def notification_count
    count = @unread_notifications.count
    if count > 0
      content_tag :span, class: "position-absolute top-25 start-50 translate-middle badge rounded-pill bg-primary", style: "font-size: 10px" do
        return '10+' if count > 10
        count.to_s
      end
    end
  end
end
