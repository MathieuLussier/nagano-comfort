class Admin::TransactionsController < Admin::AdminController
  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @transactions = Transaction.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = Transaction.all.count

    respond_to do |format|
      if @transactions
        format.html
        format.js
        format.json { render json: @transactions }
      end
    end
  end

  def show
    @transaction = Transaction.find_by_id(params[:id])

    respond_to do |format|
      if @transaction
        format.html
        format.js
        format.json { render json: @transaction }
      else
        format.html { redirect_back fallback_location: admin_transactions_path, alert: "Cannot find transaction with id #{params[:id]}" }
        format.js { render text: 'transaction not found', status: :not_found }
        format.json { render json: '{"error": "transaction not found"}', status: :not_found }
      end
    end
  end

  def new
    @transaction = Transaction.new
    @transaction.customer_id = params[:customer_id] if params[:customer_id].present?
    @transaction.reservation_id = params[:reservation_id] if params[:reservation_id].present?
    @transaction.total_due = params[:total_due] if params[:total_due].present?
  end

  def create
    @transaction = Transaction.create(params.require(:transaction))

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to admin_transaction_path(@transaction), notice: 'transaction created successfully' }
        format.js { render js: "window.location='#{admin_transaction_path(@transaction)}'", status: :created }
        format.json { render json: @transaction, status: :created, location: [:admin, @transaction] }
      else
        format.html { render action: 'new', alert: @transaction.errors.full_messages.join('. ') }
        format.js { render text: @transaction.errors.full_messages.join('. '), status: :unprocessable_entity }
        format.json { render json: @transaction.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @transaction = Transaction.find_by_id(params[:id])
  end

  def update
    @transaction = Transaction.find_by_id(params[:id])

    respond_to do |format|
      if @transaction
        if @transaction.update_attributes(params.require(:transaction))
          format.html { redirect_to edit_admin_transaction_path(@transaction), notice: "transaction #{@transaction.name} updated successfully" }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @transaction, status: :ok, location: [:admin, @transaction] }
        else
          format.html { render :edit, alert: @transaction.errors.full_messages.join('. ') }
          format.js { render text: @transaction.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @transaction.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_transactions_path, alert: "Cannot find transaction to update with id #{params[:id]}" }
        format.js { render text: 'transaction not found', status: :not_found }
        format.json { render json: '{"error": "transaction not found"}', status: :not_found }
      end
    end
  end

  def destroy
    @transaction = Transaction.find_by_id(params[:id])

    respond_to do |format|
      if @transaction
        if @transaction.destroy
          format.html { redirect_to admin_transactions_url, notice: 'transaction deleted successfully' }
          format.js { render nothing: true, status: :ok }
          format.json { render json: @transaction, status: :ok }
        else
          format.html { redirect_to :back, alert: @transaction.errors.full_messages.join('. ') }
          format.js { render text: @transaction.errors.full_messages.join('. '), status: :unprocessable_entity }
          format.json { render json: @transaction.errors.full_messages, status: :unprocessable_entity }
        end
      else
        format.html { redirect_back fallback_location: admin_transactions_url, alert: "Cannot find transaction to delete with id #{params[:id]}" }
        format.js { render text: 'transaction to delete not found', status: :not_found }
        format.json { render json: '{"error": "transaction to delete not found"}', status: :not_found }
      end
    end
  end
end
