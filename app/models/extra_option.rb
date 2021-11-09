class ExtraOption < ActiveRecord::Base
  attr_accessible :name, :description, :is_billable, :price

  validates :name, presence: true
  validates :is_billable, presence: true

  has_many :extra_option_reservation_rels
  has_many :transactions, through: :extra_option_reservation_rels
end
