class Products::ProductService

  class << self

    def create(name:, cost_price:, store:)
      product = Product.create!(name: name, cost_price: cost_price)

      StockItem.create!(product_id: product.id,
                        store_id: store.id,
                        command: StockItem::ADDED)

      product
    end
  end
end