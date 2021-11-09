class PriceVariation < ActiveRecord::Base
  attr_accessible :name, :variation_amount, :start_date, :end_date, :day_of_week, :is_discount

  validates :name, presence: true
  validates :variation_amount, presence: true
  validates :start_date, presence: true

  has_many :reservation_price_variation_rels
  has_many :reservations, through: :reservation_price_variation_rels
end
