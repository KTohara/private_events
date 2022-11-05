class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.integer :event_id
      t.integer :attendee_id

      t.timestamps
    end

    add_foreign_key :invitations, :events, column: :event_id
    add_foreign_key :invitations, :users, column: :attendee_id
  end
end
