class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :ticket_type

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
