class BedroomNeighbor < ActiveRecord::Base
  attr_accessible :bedroom_id, :neighbor_id

  validates :bedroom_id, presence: true
  validates :neighbor_id, presence: true

  belongs_to :bedroom, class_name: 'Bedroom'
  belongs_to :neighbor, class_name: 'Bedroom'
end
