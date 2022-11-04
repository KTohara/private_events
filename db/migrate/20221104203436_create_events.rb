class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :description
      t.string :location
      t.date :date
      t.references :creator, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
