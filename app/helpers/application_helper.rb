module ApplicationHelper
  def notification_count
    count = current_user.invitations.unconfirmed.count
    if count > 0
      content_tag :span, class: "position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" do
        count.to_s
      end
    end
  end
end
