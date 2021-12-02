class Client::BedroomsController < Client::ClientController
  before_filter :parse_search_params

  def parse_search_params
    params[:start_date] = Date.parse(params[:start_date]) if params[:start_date].present?
    params[:end_date] = Date.parse(params[:end_date]) if params[:end_date].present?
  end

  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i

    @bedrooms = Bedroom.order(created_at: :desc)
    @bedrooms = @bedrooms.where("name like ?", "%#{params[:bedroom_name]}%") if params[:bedroom_name].present?
    @bedrooms = @bedrooms.where(bedroom_type_id: params[:bedroom_type]) if params[:bedroom_type].present?
    @bedrooms = @bedrooms.where(view_type_id: params[:view_type]) if params[:view_type].present?
    @bedrooms = @bedrooms.where(nb_of_beds: params[:nb_of_beds]) if params[:nb_of_beds].present?
    # @bedrooms = @bedrooms.select { |b| b.check_if_available?(params[:start_date], params[:end_date]) } if params[:start_date].present? && params[:end_date].present? && params[:end_date] > params[:start_date]
    # @bedrooms = @bedrooms.available(params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present? && params[:end_date] > params[:start_date]
    @record_count = @bedrooms.count
    @bedrooms = @bedrooms.limit(@limit).offset(@pages * @limit)

    respond_to do |format|
      if @bedrooms
        format.html
        format.js
        format.json { render json: @bedrooms }
      end
    end
  end

  def show
    @bedroom = Bedroom.find_by_id(params[:id])

    respond_to do |format|
      if @bedroom
        format.html
        format.js
        format.json { render json: @bedroom }
      else
        format.html { redirect_back fallback_location: admin_bedrooms_path, alert: "Cannot find bedroom with id #{params[:id]}" }
        format.js { render text: 'bedroom not found', status: :not_found }
        format.json { render json: '{"error": "bedroom not found"}', status: :not_found }
      end
    end
  end

  def check_availability
    @bedroom = Bedroom.find_by_id(params[:id])

    if params[:start_date].present? && params[:end_date].present?
      @available = @bedroom.check_if_available?(params[:start_date], params[:end_date])
    else
      @available = false
    end

    respond_to do |format|
      if @bedroom
        format.html
        format.js
        format.json { render json: @bedroom }
      else
        format.html { redirect_back fallback_location: client_bedrooms_path, alert: "Cannot find bedroom with id #{params[:id]}" }
        format.js { render text: 'bedroom not found', status: :not_found }
        format.json { render json: '{"error": "bedroom not found"}', status: :not_found }
      end
    end
  end
end
