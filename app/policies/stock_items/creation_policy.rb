module StockItems::CreationPolicy

  include StockItems::QuantityPolicy

  def validate_whether_creation_can_be_done(product_id:, quantity:)
    raise StockItems::InvalidProductError unless product_id_is_valid? product_id

    validate_whether_quantity_is_valid(quantity)
  end

  private

  def product_id_is_valid?(product_id)
    Product.find_by_id(product_id)
  end
end