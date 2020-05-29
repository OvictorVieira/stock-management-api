module QuantityCalculable
  extend ActiveSupport::Concern

  def calculate_quantity
    number_items_added - number_items_removed
  end

  def number_items_added
    sum_quantities(self.stock_items.added)
  end

  def number_items_removed
    sum_quantities(self.stock_items.removed)
  end

  private

  def sum_quantities(collection)
    collection.reduce(0) { |sum, item| sum + item.quantity }
  end
end