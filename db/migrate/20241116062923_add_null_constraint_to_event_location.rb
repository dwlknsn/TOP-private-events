class AddNullConstraintToEventLocation < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:events, :location, false)
  end
end
