class Admin::BedroomStatusesController < Admin::AdminController
  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @bedroom_statuses = BedroomStatus.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = BedroomStatus.all.count

    respond_to do |format|
      if @bedroom_statuses
        format.html
        format.js
        format.json { render json: @bedroom_statuses }
      end
    end
  end

  def new
    @bedroom_status = BedroomStatus.new
  end

  def create
    @bedroom_status = BedroomStatus.create(params.require(:bedroom_status))

    respond_to do |format|
      if @bedroom_status.save
        format.html { redirect_to admin_bedroom_statuses_path, notice: 'Bedroom status created successfully' }
        format.js { render js: "window.location='#{admin_bedroom_statuses_path}'", status: :created }
        format.json { render json: @bedroom_status, status: :created, location: [:admin, @bedroom_status] }
      else
        format.html { render action: 'new', alert: @bedroom_status.errors.full_messages.join('. ') }
        format.js { render text: @bedroom_status.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @bedroom_status.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @bedroom_status = BedroomStatus.find_by_id(params[:id])
  end

  def update
    @bedroom_status = BedroomStatus.find_by_id(params[:id])

    respond_to do |format|
      if @bedroom_status
        if @bedroom_status.update_attributes(params.require(:bedroom_status))
          format.html { redirect_to edit_admin_bedroom_status_path(@bedroom_status), notice: "Bedroom status #{@bedroom_status.name} updated successfully" }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @bedroom_status, status: :ok, location: [:admin, @bedroom_status] }
        else
          format.html { render :edit, alert: @bedroom_status.errors.full_messages.join('. ') }
          format.js { render text: @bedroom_status.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @bedroom_status.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_bedroom_statuses_path, alert: "Cannot find bedroom status to update with id #{params[:id]}" }
        format.js { render text: 'bedroom status not found', status: :not_found }
        format.json { render json: '{"error": "bedroom status not found"}', status: :not_found }
      end
    end
  end

  def destroy
    @bedroom_status = BedroomStatus.find_by_id(params[:id])

    respond_to do |format|
      if @bedroom_status
        if @bedroom_status.destroy
          format.html { redirect_to admin_bedroom_statuses_url, notice: 'Bedroom status deleted successfully' }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @bedroom_status, status: :ok }
        else
          format.html { redirect_to :back, alert: @bedroom_status.errors.full_messages.join('. ') }
          format.js { render text: @bedroom_status.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @bedroom_status.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_bedroom_statuses_url, alert: "Cannot find bedroom status to delete with id #{params[:id]}" }
        format.js { render text: 'bedroom status to delete not found', status: :not_found }
        format.json { render json: '{"error": "bedroom status to delete not found"}', status: :not_found }
      end
    end
  end
end
