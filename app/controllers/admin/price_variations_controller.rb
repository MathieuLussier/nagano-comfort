class Admin::PriceVariationsController < Admin::AdminController
  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @price_variations = PriceVariation.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = PriceVariation.all.count

    respond_to do |format|
      if @price_variations
        format.html
        format.js
        format.json { render json: @price_variations }
      end
    end
  end

  def show
    @price_variation = PriceVariation.find_by_id(params[:id])

    respond_to do |format|
      if @price_variation
        format.html
        format.js
        format.json { render json: @price_variation }
      else
        format.html { redirect_back fallback_location: admin_price_variations_path, alert: "Cannot find price variation with id #{params[:id]}" }
        format.js { render text: 'price variation not found', status: :not_found }
        format.json { render json: '{"error": "price variation not found"}', status: :not_found }
      end
    end
  end

  def new
    @price_variation = PriceVariation.new
  end

  def create
    @price_variation = PriceVariation.create(params.require(:price_variation))

    respond_to do |format|
      if @price_variation.save
        format.html { redirect_to admin_price_variations_path, notice: 'price variation created successfully' }
        format.js { render js: "window.location='#{admin_price_variations_path}'", status: :created }
        format.json { render json: @price_variation, status: :created, location: [:admin, @price_variation] }
      else
        format.html { render action: 'new', alert: @price_variation.errors.full_messages.join('. ') }
        format.js { render text: @price_variation.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @price_variation.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @price_variation = PriceVariation.find_by_id(params[:id])
  end

  def update
    @price_variation = PriceVariation.find_by_id(params[:id])

    respond_to do |format|
      if @price_variation
        if @price_variation.update_attributes(params.require(:price_variation))
          format.html { redirect_to edit_admin_price_variation_path(@price_variation), notice: "price variation #{@price_variation.name} updated successfully" }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @price_variation, status: :ok, location: [:admin, @price_variation] }
        else
          format.html { render :edit, alert: @price_variation.errors.full_messages.join('. ') }
          format.js { render text: @price_variation.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @price_variation.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_price_variations_path, alert: "Cannot find price variation to update with id #{params[:id]}" }
        format.js { render text: 'price variation not found', status: :not_found }
        format.json { render json: '{"error": "price variation not found"}', status: :not_found }
      end
    end
  end

  def destroy
    @price_variation = PriceVariation.find_by_id(params[:id])

    respond_to do |format|
      if @price_variation
        if @price_variation.destroy
          format.html { redirect_to admin_price_variations_url, notice: 'price variation deleted successfully' }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @price_variation, status: :ok }
        else
          format.html { redirect_to :back, alert: @price_variation.errors.full_messages.join('. ') }
          format.js { render text: @price_variation.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @price_variation.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_price_variations_url, alert: "Cannot find price variation to delete with id #{params[:id]}" }
        format.js { render text: 'price variation to delete not found', status: :not_found }
        format.json { render json: '{"error": "price variation to delete not found"}', status: :not_found }
      end
    end
  end
end
