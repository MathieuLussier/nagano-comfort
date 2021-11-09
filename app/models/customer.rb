class Customer < ActiveRecord::Base
  attr_accessible :name, :email, :phone

  validates :name, presence: true

  has_many :reservations, dependent: :destroy
  has_many :transactions, dependent: :destroy
end
