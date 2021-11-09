class Bedroom < ActiveRecord::Base
  attr_accessible :name, :bedroom_type_id, :bedroom_status_id, :view_type_id, :price_per_night, :nb_of_beds

  validates :name, presence: true, length: { minimum: 3, maximum: 45 }
  validates :bedroom_type_id, presence: true
  validates :bedroom_status_id, presence: true
  validates :view_type_id, presence: true
  validates :price_per_night, presence: true

  belongs_to :bedroom_type
  belongs_to :bedroom_status
  belongs_to :view_type

  has_many :bedroom_neighbors
  has_many :neighbors, through: :bedroom_neighbors
  has_many :reservation_bedroom_rel
  has_many :reservations, through: :reservation_bedroom_rel
end
