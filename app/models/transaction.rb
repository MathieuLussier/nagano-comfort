class Transaction < ActiveRecord::Base
  attr_accessible :reservation_id, :customer_id, :sub_total, :transaction_date

  validates :reservation_id, presence: true
  validates :customer_id, presence: true

  belongs_to :reservation, class_name: 'Reservation'
  belongs_to :customer, class_name: 'Customer'

  after_validation :calculate_sub_totals

  def calculate_sub_totals
    self.sub_total = 0.0
    duration = self.reservation.duration
    valid_extra_options = self.reservation.extra_options.select(&:is_billable?)

    valid_extra_options.each do |extra_option|
      self.sub_total += duration * extra_option.price.to_f
    end

    self.reservation.bedrooms.each do |bedroom|
      self.sub_total += duration * bedroom.price_per_night.to_f
    end

    if self.reservation.discount
      self.sub_total -= self.sub_total.to_f * self.reservation.discount.discount_amount.to_f
    end
  end
end
