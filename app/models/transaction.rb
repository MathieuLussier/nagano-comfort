class Transaction < ActiveRecord::Base
  attr_accessible :reservation_id, :customer_id, :reservation, :customer, :sub_total, :transaction_date, :total_due, :is_paid

  validates :reservation_id, presence: true
  validates :customer_id, presence: true

  belongs_to :reservation, class_name: 'Reservation'
  belongs_to :customer, class_name: 'Customer'

  # after_validation :calculate_sub_totals
  #
  # def calculate_sub_totals
  #   total = 0.0
  #
  #   self.reservation.bedrooms.each do |bedroom|
  #     total += self.reservation.duration.to_i * bedroom.price_per_night.to_f
  #   end
  #
  #   self.reservation.price_variations.each do |price_variation|
  #     if price_variation.is_discount?
  #       total -= price_variation.variation_amount.to_f * total
  #     else
  #       total += price_variation.variation_amount.to_f * total
  #     end
  #   end
  #
  #   self.sub_total = total
  # end
end
