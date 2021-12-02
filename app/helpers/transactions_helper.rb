module TransactionsHelper
  def card_transaction(transaction)
    @transaction = transaction
    render partial: 'shared/transactions/card'
  end
end
