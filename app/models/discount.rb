class Discount < ActiveRecord::Base
  attr_accessible :name, :discount_amount, :start_date, :end_date

  validates :name, presence: true
  validates :discount_amount, presence: true
  validates :start_date, presence: true

  has_many :reservations
end
