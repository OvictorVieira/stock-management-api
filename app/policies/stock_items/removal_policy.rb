module StockItems::RemovalPolicy

  def validate_whether_removal_can_be_done(quantity_withdrawn:, current_quantity:)
    raise StockItems::InsufficientQuantityError unless enough_quantity?(quantity_withdrawn: quantity_withdrawn,
                                                                        current_quantity: current_quantity)
  end

  def enough_quantity?(quantity_withdrawn:, current_quantity:)
    current_quantity.present? && quantity_withdrawn <= current_quantity
  end
end