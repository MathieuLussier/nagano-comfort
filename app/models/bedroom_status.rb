class BedroomStatus < ActiveRecord::Base
  attr_accessible :key, :label

  validates :key, presence: true
  validates :label, presence: true

  has_many :bedrooms
end
