class Reservation < ActiveRecord::Base
  attr_accessible :customer_id, :discount_id, :description, :in_date, :out_date, :nb_guests, :duration

  validates :customer_id, presence: true
  validates :in_date, presence: true

  belongs_to :customer, foreign_key: :customer_id, class_name: 'Customer'
  belongs_to :discount, foreign_key: :discount_id, class_name: 'Discount'

  has_many :reservation_bedroom_rels
  has_many :bedrooms, through: :reservation_bedroom_rels, dependent: :destroy
  has_many :transactions, class_name: 'Transaction'
  has_many :extra_option_reservation_rels
  has_many :extra_options, through: :extra_option_reservation_rels
end
