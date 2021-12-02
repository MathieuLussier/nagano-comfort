class Admin::ViewTypesController < Admin::AdminController
  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @view_types = ViewType.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = ViewType.all.count

    respond_to do |format|
      if @view_types
        format.html
        format.js
        format.json { render json: @view_types }
      end
    end
  end

  def new
    @view_type = ViewType.new
  end

  def create
    @view_type = ViewType.create(params.require(:view_type))

    respond_to do |format|
      if @view_type.save
        format.html { redirect_to admin_view_types_path, notice: 'view type created successfully' }
        format.js { render js: "window.location='#{admin_view_types_path}'", status: :created }
        format.json { render json: @view_type, status: :created, location: [:admin, @view_type] }
      else
        format.html { render action: 'new', alert: @view_type.errors.full_messages.join('. ') }
        format.js { render text: @view_type.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @view_type.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @view_type = ViewType.find_by_id(params[:id])
  end

  def update
    @view_type = ViewType.find_by_id(params[:id])

    respond_to do |format|
      if @view_type
        if @view_type.update_attributes(params.require(:view_type))
          format.html { redirect_to edit_admin_view_type_path(@view_type), notice: "view type #{@view_type.name} updated successfully" }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @view_type, status: :ok, location: [:admin, @view_type] }
        else
          format.html { render :edit, alert: @view_type.errors.full_messages.join('. ') }
          format.js { render text: @view_type.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @view_type.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_view_types_path, alert: "Cannot find view type to update with id #{params[:id]}" }
        format.js { render text: 'view type not found', status: :not_found }
        format.json { render json: '{"error": "view type not found"}', status: :not_found }
      end
    end
  end

  def destroy
    @view_type = ViewType.find_by_id(params[:id])

    respond_to do |format|
      if @view_type
        if @view_type.destroy
          format.html { redirect_to admin_view_types_url, notice: 'view type deleted successfully' }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @view_type, status: :ok }
        else
          format.html { redirect_to :back, alert: @view_type.errors.full_messages.join('. ') }
          format.js { render text: @view_type.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @view_type.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_view_types_url, alert: "Cannot find view type to delete with id #{params[:id]}" }
        format.js { render text: 'view type to delete not found', status: :not_found }
        format.json { render json: '{"error": "view type to delete not found"}', status: :not_found }
      end
    end
  end
end
