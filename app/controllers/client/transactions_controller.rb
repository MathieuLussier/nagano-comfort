class Client::TransactionsController < Client::ClientController
  def index
    @pages = params[:pages].to_i
    @limit = params[:limit].to_i
    @transactions = Transaction.where(customer_id: @current_user_id)
    @transactions = @transactions.order(created_at: :desc).limit(@limit).offset(@pages * @limit)
    @record_count = @transactions.count

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
        format.html { redirect_back fallback_location: client_transactions_path, alert: "Cannot find transaction with id #{params[:id]}" }
        format.js { render text: 'transaction not found', status: :not_found }
        format.json { render json: '{"error": "transaction not found"}', status: :not_found }
      end
    end
  end
end
