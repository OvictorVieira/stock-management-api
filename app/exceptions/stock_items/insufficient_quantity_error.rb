class StockItems::InsufficientQuantityError < StockItems::RecordInvalid

  def initialize
    super(I18n.t('activerecord.errors.messages.record_invalid',
                 errors: I18n.t('stock_items.errors.insufficient_quantity')))
  end
end