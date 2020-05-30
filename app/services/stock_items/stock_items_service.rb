class StockItems::StockItemsService

  class << self

    include StockItems::CreationPolicy
    include StockItems::RemovalPolicy

    def add_item(store_id:, product_id:, quantity:)
      validate_product_and_quantity(product_id: product_id, quantity: quantity)

      create_store_item(store_id: store_id, quantity: quantity, command: StockItem::ADDED)
    end

    def remove_item(store_id:, product_id:, quantity_withdrawn:)
      validate_product_and_quantity(product_id: product_id, quantity: quantity_withdrawn)

      current_quantity = @product.calculate_quantity

      validate_whether_removal_can_be_done(quantity_withdrawn: quantity_withdrawn,
                                           current_quantity: current_quantity)

      create_store_item(store_id: store_id, quantity: quantity_withdrawn, command: StockItem::REMOVED)
    end

    private

    def validate_product_and_quantity(product_id:, quantity:)
      @product = Product.find_by_id(product_id)

      validate_whether_creation_can_be_done(product: @product, quantity: quantity)
    end

    def create_store_item(store_id:, quantity:, command:)
      StockItem.create!(store_id: store_id,
                        product_id: @product.id,
                        quantity: quantity,
                        command: command)
    end
  end
end