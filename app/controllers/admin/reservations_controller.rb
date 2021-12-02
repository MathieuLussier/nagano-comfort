class Admin::ReservationsController < Admin::AdminController
  before_filter :ensure_bedrooms_data, only: [:create, :update]
  before_filter :ensure_price_variations_data, only: [:create, :update]

  def ensure_bedrooms_data
    if params[:reservation].present? && params[:reservation][:bedrooms].present?
      params[:reservation][:bedrooms] = Bedroom.find(params[:reservation][:bedrooms].reject(&:empty?))
    end
  end

  def ensure_price_variations_data
    if params[:reservation].present? && params[:reservation][:price_variations].present?
      params[:reservation][:price_variations] = PriceVariation.find(params[:reservation][:price_variations].reject(&:empty?))
    end
  end

  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @reservations = Reservation.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = Reservation.all.count

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
        format.html { redirect_back fallback_location: admin_reservations_path, alert: "Cannot find reservation with id #{params[:id]}" }
        format.js { render text: 'reservation not found', status: :not_found }
        format.json { render json: '{"error": "reservation not found"}', status: :not_found }
      end
    end
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.create(params.require(:reservation))

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to admin_reservation_path(@reservation), notice: 'Reservation created successfully' }
        format.js { render js: "window.location='#{admin_reservation_path(@reservation)}'", status: :created }
        format.json { render json: @reservation, status: :created, location: [:admin, @reservation] }
      else
        format.html { render action: 'new', alert: @reservation.errors.full_messages.join('. ') }
        format.js { render text: @reservation.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @reservation.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @reservation = Reservation.find_by_id(params[:id])
  end

  def update
    @reservation = Reservation.find_by_id(params[:id])

    respond_to do |format|
      if @reservation
        if @reservation.update_attributes(params.require(:reservation))
          format.html { redirect_to edit_admin_reservation_path(@reservation), notice: "Reservation #{@reservation.name} updated successfully" }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @reservation, status: :ok, location: [:admin, @reservation] }
        else
          format.html { render :edit, alert: @reservation.errors.full_messages.join('. ') }
          format.js { render text: @reservation.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @reservation.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_reservations_path, alert: "Cannot find reservation to update with id #{params[:id]}" }
        format.js { render text: 'reservation not found', status: :not_found }
        format.json { render json: '{"error": "reservation not found"}', status: :not_found }
      end
    end
  end

  def destroy
    @reservation = Reservation.find_by_id(params[:id])

    respond_to do |format|
      if @reservation
        if @reservation.destroy
          format.html { redirect_to admin_reservations_url, notice: 'Reservation deleted successfully' }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @reservation, status: :ok }
        else
          format.html { redirect_to :back, alert: @reservation.errors.full_messages.join('. ') }
          format.js { render text: @reservation.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @reservation.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_reservations_url, alert: "Cannot find reservation to delete with id #{params[:id]}" }
        format.js { render text: 'reservation to delete not found', status: :not_found }
        format.json { render json: '{"error": "reservation to delete not found"}', status: :not_found }
      end
    end
  end
end
