class AddQuantitiesToTicketTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :ticket_types, :total_quantity, :integer
    add_column :ticket_types, :available_quantity, :integer
  end
end
