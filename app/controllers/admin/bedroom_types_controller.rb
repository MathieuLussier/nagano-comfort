class Admin::BedroomTypesController < Admin::AdminController
  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @bedroom_types = BedroomType.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = BedroomType.all.count

    respond_to do |format|
      if @bedroom_types
        format.html
        format.js
        format.json { render json: @bedroom_types }
      end
    end
  end

  def new
    @bedroom_type = BedroomType.new
  end

  def create
    @bedroom_type = BedroomType.create(params.require(:bedroom_type))

    respond_to do |format|
      if @bedroom_type.save
        format.html { redirect_to admin_bedroom_types_path, notice: 'Bedroom type created successfully' }
        format.js { render js: "window.location='#{admin_bedroom_types_path}'", status: :created }
        format.json { render json: @bedroom_type, status: :created, location: [:admin, @bedroom_type] }
      else
        format.html { render action: 'new', alert: @bedroom_type.errors.full_messages.join('. ') }
        format.js { render text: @bedroom_type.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @bedroom_type.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @bedroom_type = BedroomType.find_by_id(params[:id])
  end

  def update
    @bedroom_type = BedroomType.find_by_id(params[:id])

    respond_to do |format|
      if @bedroom_type
        if @bedroom_type.update_attributes(params.require(:bedroom_type))
          format.html { redirect_to edit_admin_bedroom_type_path(@bedroom_type), notice: "Bedroom type #{@bedroom_type.name} updated successfully" }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @bedroom_type, status: :ok, location: [:admin, @bedroom_type] }
        else
          format.html { render :edit, alert: @bedroom_type.errors.full_messages.join('. ') }
          format.js { render text: @bedroom_type.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @bedroom_type.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_bedroom_types_path, alert: "Cannot find bedroom type to update with id #{params[:id]}" }
        format.js { render text: 'bedroom type not found', status: :not_found }
        format.json { render json: '{"error": "bedroom type not found"}', status: :not_found }
      end
    end
  end

  def destroy
    @bedroom_type = BedroomType.find_by_id(params[:id])

    respond_to do |format|
      if @bedroom_type
        if @bedroom_type.destroy
          format.html { redirect_to admin_bedroom_types_url, notice: 'Bedroom type deleted successfully' }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @bedroom_type, status: :ok }
        else
          format.html { redirect_to :back, alert: @bedroom_type.errors.full_messages.join('. ') }
          format.js { render text: @bedroom_type.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @bedroom_type.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_bedroom_types_url, alert: "Cannot find bedroom type to delete with id #{params[:id]}" }
        format.js { render text: 'bedroom type to delete not found', status: :not_found }
        format.json { render json: '{"error": "bedroom type to delete not found"}', status: :not_found }
      end
    end
  end
end
