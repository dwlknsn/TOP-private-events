class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.date :date
      t.time :time
      t.text :location
      t.belongs_to :host, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
