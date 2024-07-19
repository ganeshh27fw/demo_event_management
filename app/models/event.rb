class Event < ApplicationRecord
  has_many :ticket_types,dependent: :destroy
  has_many :bookings,dependent: :destroy
  
  has_many :users, through: :bookings
  has_one_attached :image
  validates :name, :description, :date, :city, :producer, :artists, presence: true
  validate :date_cannot_be_in_the_past

  private

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end

 include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "events_#{Rails.env}"

 # Define the Elasticsearch index mappings
  settings index: { number_of_shards: 1 } do
    mappings dynamic: false do
      indexes :name, type: :text, analyzer: 'english'
      indexes :artists, type: :text, analyzer: 'english'
      indexes :producer, type: :text, analyzer: 'english'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: %w[name artists producer]
          }
        }
      }
    )
  end

    def as_indexed_json(options = {})
    self.as_json(
      only: [:name, :artists, :producer]
    )
  end

  

end



