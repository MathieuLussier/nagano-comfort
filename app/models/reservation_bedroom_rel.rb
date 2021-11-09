class ReservationBedroomRel < ActiveRecord::Base
  attr_accessible :bedroom_id, :reservation_id

  validates :bedroom_id, presence: true
  validates :reservation_id, presence: true

  belongs_to :bedroom, class_name: 'Bedroom'
  belongs_to :reservation, class_name: 'Reservation'
end
