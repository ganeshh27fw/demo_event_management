class AddTicketTypeIdToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :ticket_type_id, :integer
  end
end
