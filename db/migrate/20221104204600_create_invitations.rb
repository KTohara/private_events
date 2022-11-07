class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.integer :status, null: false, default: 1
      t.references :event, foreign_key: true
      t.references :attendee, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
