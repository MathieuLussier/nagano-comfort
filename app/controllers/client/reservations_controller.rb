class Client::ReservationsController < Client::ClientController
  before_filter :ensure_bedrooms_data, only: [:create, :update]

  def ensure_bedrooms_data
    if params[:reservation].present? && params[:reservation][:bedrooms].present?
      params[:reservation][:bedrooms] = Bedroom.find(params[:reservation][:bedrooms].reject(&:empty?))
    end
  end

  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @reservations = Reservation.where(customer_id: @current_user_id)
    @reservations = @reservations.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = @reservations.count

    respond_to do |format|
      if @reservations
        format.html
        format.js
        format.json { render json: @reservations }
      end
    end
  end

  def show
    @reservation = Reservation.find_by_id(params[:id])

    respond_to do |format|
      if @reservation
        format.html
        format.js
        format.json { render json: @reservation }
      else
        format.html { redirect_back fallback_location: client_reservations_path, alert: "Cannot find reservation with id #{params[:id]}" }
        format.js { render text: 'reservation not found', status: :not_found }
        format.json { render json: '{"error": "reservation not found"}', status: :not_found }
      end
    end
  end

  def new
    params.require(:bedroom_id)
    params.require(:customer_id)
    params.require(:in_date)
    params.require(:duration)

    @reservation = Reservation.new
    @reservation.customer_id = params[:customer_id]
    @reservation.in_date = params[:in_date]
    @reservation.duration = params[:duration]
    bedroom = Bedroom.find_by_id(params[:bedroom_id])
    @reservation.bedrooms << bedroom
    @bedrooms_allowed_ids = [bedroom.id] + bedroom.neighbors.map(&:id)
  end

  def create
    @reservation = Reservation.create(params.require(:reservation).except(:bedrooms))
    beds_to_add = Bedroom.find_all_by_id(params[:reservation][:bedrooms])
    @reservation.bedrooms << beds_to_add

    respond_to do |format|
      if @reservation.save
        ReservationConfirmation.reservation_confirmation_email(@current_user, @reservation).deliver
        format.html { redirect_to client_reservation_path(@reservation), notice: 'Reservation created successfully' }
        format.js { render js: "window.location='#{client_reservation_path(@reservation)}'", status: :created }
        format.json { render json: @reservation, status: :created, location: [:admin, @reservation] }
      else
        format.html { render action: 'new', alert: @reservation.errors.full_messages.join('. ') }
        format.js { render text: @reservation.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @reservation.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
end
