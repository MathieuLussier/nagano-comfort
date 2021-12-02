class ViewType < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many :bedrooms, class_name: 'Bedroom'
end
