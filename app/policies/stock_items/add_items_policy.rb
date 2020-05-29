module StockItems::AddItemsPolicy

  include StockItems::QuantityPolicy

  def validate_whether_quantity_update_can_be_done(quantity)

    validate_whether_quantity_is_valid(quantity)
  end
end