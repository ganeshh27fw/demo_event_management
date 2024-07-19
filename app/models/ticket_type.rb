class TicketType < ApplicationRecord
  belongs_to :event 
  has_many :bookings, dependent: :destroy


  validates :name, :price, :total_quantity, :available_quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :total_quantity, numericality: { only_integer: true, greater_than: 0 }
  
  before_validation :set_available_quantity, on: :create

  private

  def set_available_quantity
    self.available_quantity = total_quantity if available_quantity.nil?
  end
end
