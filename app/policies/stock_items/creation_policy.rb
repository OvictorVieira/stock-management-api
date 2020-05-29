module StockItems::CreationPolicy

  include StockItems::QuantityPolicy

  def validate_whether_creation_can_be_done(product:, quantity:)
    raise StockItems::InvalidProductError unless product.present?

    validate_whether_quantity_is_valid(quantity)
  end
end