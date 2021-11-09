class ExtraOptionReservationRel < ActiveRecord::Base
  attr_accessible :extra_option_id, :reservation_id

  belongs_to :extra_option, class_name: 'ExtraOption'
  belongs_to :reservation, class_name: 'Reservation'
end
