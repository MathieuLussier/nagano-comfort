module ReservationsHelper
  def card_reservation(reservation)
    @reservation = reservation
    render partial: 'shared/reservations/card'
  end

  def get_duration(start_date, end_date)
    (end_date - start_date).to_i
  end
end
