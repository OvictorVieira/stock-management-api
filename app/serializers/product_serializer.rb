class ProductSerializer < ApplicationSerializer

  attributes :id, :name, :cost_price

  class << self

    def serialize_collection(products, current_page, per_page, total_products)
      {
        current_page: current_page,
        per_page: per_page,
        total_products: total_products,
        products: products.map(&method(:format))
      }
    end

    private

    def format(product)
      {
        id: product.id,
        name: product.name,
        cost_price: product.cost_price.to_f
      }
    end

  end
end
