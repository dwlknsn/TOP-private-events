class CreateSignUps < ActiveRecord::Migration[8.0]
  def change
    create_table :sign_ups do |t|
      t.belongs_to :event, null: false, foreign_key: true
      t.belongs_to :attendee, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
