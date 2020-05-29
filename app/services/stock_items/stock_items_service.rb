class StockItems::StockItemsService

  class << self

    include StockItems::CreationPolicy

    def add_item(store_id:, product_id:, quantity:)
      create_store_item(store_id: store_id,
                        product_id: product_id,
                        quantity: quantity,
                        command: StockItem::ADDED)
    end

    private

    def create_store_item(store_id:, product_id:, quantity:, command:)
      validate_whether_creation_can_be_done(product_id: product_id, quantity: quantity)

      StockItem.create!(store_id: store_id,
                        product_id: product_id,
                        quantity: quantity,
                        command: command)
    end
  end
end