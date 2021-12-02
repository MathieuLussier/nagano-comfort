class Admin::CustomersController < Admin::AdminController
  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @customers = Customer.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = Customer.all.count

    respond_to do |format|
      if @customers
        format.html
        format.js
        format.json { render json: @customers }
      end
    end
  end

  def show
    @customer = Customer.find_by_id(params[:id])

    respond_to do |format|
      if @customer
        format.html
        format.js
        format.json { render json: @customer }
      else
        format.html { redirect_back fallback_location: admin_customers_path, alert: "Cannot find customer with id #{params[:id]}" }
        format.js { render text: 'customer not found', status: :not_found }
        format.json { render json: '{"error": "customer not found"}', status: :not_found }
      end
    end
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(params.require(:customer))

    respond_to do |format|
      if @customer.save
        format.html { redirect_to admin_customers_path, notice: 'customer created successfully' }
        format.js { render js: "window.location='#{admin_customers_path}'", status: :created }
        format.json { render json: @customer, status: :created, location: [:admin, @customer] }
      else
        format.html { render action: 'new', alert: @customer.errors.full_messages.join('. ') }
        format.js { render text: @customer.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @customer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @customer = Customer.find_by_id(params[:id])
  end

  def update
    @customer = Customer.find_by_id(params[:id])

    respond_to do |format|
      if @customer
        if @customer.update_attributes(params.require(:customer))
          format.html { redirect_to edit_admin_customer_path(@customer), notice: "customer #{@customer.name} updated successfully" }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @customer, status: :ok, location: [:admin, @customer] }
        else
          format.html { render :edit, alert: @customer.errors.full_messages.join('. ') }
          format.js { render text: @customer.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @customer.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_customers_path, alert: "Cannot find customer to update with id #{params[:id]}" }
        format.js { render text: 'customer not found', status: :not_found }
        format.json { render json: '{"error": "customer not found"}', status: :not_found }
      end
    end
  end

  def destroy
    @customer = Customer.find_by_id(params[:id])

    respond_to do |format|
      if @customer
        if @customer.destroy
          format.html { redirect_to admin_customers_url, notice: 'customer deleted successfully' }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @customer, status: :ok }
        else
          format.html { redirect_to :back, alert: @customer.errors.full_messages.join('. ') }
          format.js { render text: @customer.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @customer.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_customers_url, alert: "Cannot find customer to delete with id #{params[:id]}" }
        format.js { render text: 'customer to delete not found', status: :not_found }
        format.json { render json: '{"error": "customer to delete not found"}', status: :not_found }
      end
    end
  end
end
