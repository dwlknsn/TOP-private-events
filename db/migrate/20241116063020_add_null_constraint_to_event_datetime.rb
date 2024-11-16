class AddNullConstraintToEventDatetime < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:events, :datetime, false)
  end
end
