class AddStatusToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :status, :integer, default: 1
  end
end
