class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.datetime :requested_at, null: false, default: Time.now
      t.datetime :accepted_at
      t.datetime :declined_at
      t.datetime :expires_at, null: false
      t.belongs_to :event, null: false, foreign_key: true
      t.belongs_to :invitee, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
