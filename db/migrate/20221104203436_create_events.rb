class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :description
      t.string :location
      t.date :date
      t.integer :creator_id

      t.timestamps
    end

    add_foreign_key :events, :users, column: :creator_id
  end
end
