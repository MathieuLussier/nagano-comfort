class ReservationConfirmation < ActionMailer::Base
  default from: "mathilekiki@hotmail.com"

  def reservation_confirmation_email(user, reservation)
    @customer = user
    @reservation = reservation

    mail(to: @customer.email, subject: "Reservation created")
  end
end
