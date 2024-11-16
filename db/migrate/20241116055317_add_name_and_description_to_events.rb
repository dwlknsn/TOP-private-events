class AddNameAndDescriptionToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :name, :string, null: false
    add_column :events, :description, :text, null: false
  end
end
