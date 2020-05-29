class StockItems::InvalidProductError < StockItems::RecordInvalid

  def initialize
    super(I18n.t('activerecord.errors.messages.record_invalid',
                 errors: I18n.t('stock_items.errors.invalid_product')))
  end
end