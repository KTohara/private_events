class ChangeMultipleToEvents < ActiveRecord::Migration[7.0]
  def change
    change_column_null :events, :description, false
    change_column_null :events, :location, false
    change_column_null :events, :date, false
    change_column_null :events, :creator_id, false
  end
end
