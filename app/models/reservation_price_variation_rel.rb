class ReservationPriceVariationRel < ActiveRecord::Base
  attr_accessible :price_variation_id, :reservation_id

  belongs_to :price_variation, class_name: 'PriceVariation'
  belongs_to :reservation, class_name: 'Reservation'
end
