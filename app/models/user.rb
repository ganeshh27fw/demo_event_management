class User < ApplicationRecord

  has_many :bookings
  has_many :events, through: :bookings
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 'user', admin: 'admin' }

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :user
  end
end
