module StockItems::QuantityPolicy

  def validate_whether_quantity_is_valid(quantity)
    raise StockItems::InvalidQuantityError unless quantity_is_a_valid_value? quantity
  end

  private

  def quantity_is_a_valid_value?(quantity)
    quantity.to_s.match? regex_to_positive_integers
  end

  def regex_to_positive_integers
    /\A[1-9]\d*\Z/
  end
end