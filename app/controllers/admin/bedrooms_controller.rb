class Admin::BedroomsController < Admin::AdminController
  before_filter :ensure_neighbors_data, only: [:create, :update]

  def ensure_neighbors_data
    if params[:bedroom].present? && params[:bedroom][:neighbors].present?
      params[:bedroom][:neighbors] = Bedroom.find(params[:bedroom][:neighbors].reject(&:empty?))
    end
  end

  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @bedrooms = Bedroom.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = Bedroom.all.count

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

  def new
    @bedroom = Bedroom.new
  end

  def create
    @bedroom = Bedroom.create(params.require(:bedroom))

    respond_to do |format|
      if @bedroom.save
        format.html { redirect_to admin_bedroom_path(@bedroom), notice: 'Bedroom created successfully' }
        format.js { render js: "window.location='#{admin_bedroom_path(@bedroom)}'", status: :created }
        format.json { render json: @bedroom, status: :created, location: [:admin, @bedroom] }
      else
        format.html { render action: 'new', alert: @bedroom.errors.full_messages.join('. ') }
        format.js { render text: @bedroom.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @bedroom.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @bedroom = Bedroom.find_by_id(params[:id])
  end

  def update
    @bedroom = Bedroom.find_by_id(params[:id])

    respond_to do |format|
      if @bedroom
        if @bedroom.update_attributes(params.require(:bedroom))
          format.html { redirect_to edit_admin_bedroom_path(@bedroom), notice: "Bedroom #{@bedroom.name} updated successfully" }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @bedroom, status: :ok, location: [:admin, @bedroom] }
        else
          format.html { render :edit, alert: @bedroom.errors.full_messages.join('. ') }
          format.js { render text: @bedroom.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @bedroom.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_bedrooms_path, alert: "Cannot find bedroom to update with id #{params[:id]}" }
        format.js { render text: 'bedroom not found', status: :not_found }
        format.json { render json: '{"error": "bedroom not found"}', status: :not_found }
      end
    end
  end

  def destroy
    @bedroom = Bedroom.find_by_id(params[:id])

    respond_to do |format|
      if @bedroom
        if @bedroom.destroy
          format.html { redirect_to admin_bedrooms_url, notice: 'Bedroom deleted successfully' }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @bedroom, status: :ok }
        else
          format.html { redirect_to :back, alert: @bedroom.errors.full_messages.join('. ') }
          format.js { render text: @bedroom.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @bedroom.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_bedrooms_url, alert: "Cannot find bedroom to delete with id #{params[:id]}" }
        format.js { render text: 'bedroom to delete not found', status: :not_found }
        format.json { render json: '{"error": "bedroom to delete not found"}', status: :not_found }
      end
    end
  end
end