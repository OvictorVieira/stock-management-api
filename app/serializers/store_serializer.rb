class StoreSerializer < ApplicationSerializer

  attributes :id, :name, :address

  class << self

    def serialize_collection(stores, current_page, per_page, total_stores)
      {
        current_page: current_page,
        per_page: per_page,
        total_stores: total_stores,
        stores: stores.map(&method(:format))
      }
    end

    private

    def format(store)
      {
        id: store.id,
        name: store.name,
        address: store.address
      }
    end

  end
end
