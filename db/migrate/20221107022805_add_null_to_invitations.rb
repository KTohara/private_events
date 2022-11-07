class AddNullToInvitations < ActiveRecord::Migration[7.0]
  def change
    change_column_null :invitations, :attendee_id, false
    change_column_null :invitations, :event_id, false
  end
end
