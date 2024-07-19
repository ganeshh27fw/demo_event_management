class AddCascadeDeleteToEvents < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :ticket_types, :events
    remove_foreign_key :bookings, :events

    add_foreign_key :ticket_types, :events, on_delete: :cascade
    add_foreign_key :bookings, :events, on_delete: :cascade
  end
end

