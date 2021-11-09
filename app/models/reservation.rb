class Reservation < ActiveRecord::Base
  attr_accessible :customer_id, :description, :in_date, :out_date, :nb_guests, :duration

  validates :customer_id, presence: true
  validates :in_date, presence: true

  belongs_to :customer, foreign_key: :customer_id, class_name: 'Customer'

  has_many :reservation_bedroom_rels
  has_many :bedrooms, through: :reservation_bedroom_rels
  has_many :transactions, class_name: 'Transaction'
  has_many :reservation_price_variation_rels
  has_many :price_variations, through: :reservation_price_variation_rels
end
