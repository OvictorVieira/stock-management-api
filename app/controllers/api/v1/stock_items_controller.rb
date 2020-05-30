class Api::V1::StockItemsController < ApplicationController

  def add_item
    begin
      permitted = permitted_params

      StockItems::StockItemsService.add_item(store_id: current_store.id,
                                             product_id: permitted[:product_id],
                                             quantity: permitted[:quantity])

      render status: :created

    rescue StockItems::RecordInvalid, ActiveRecord::RecordInvalid, StandardError => error

      render json: build_error(error.message), status: :unprocessable_entity
    end
  end

  def remove_item
    begin
      permitted = permitted_params

      StockItems::StockItemsService.remove_item(store_id: current_store.id,
                                                product_id: permitted[:product_id],
                                                quantity_withdrawn: permitted[:quantity])

      render status: :created

    rescue StockItems::RecordInvalid, ActiveRecord::RecordInvalid, StandardError => error

      render json: build_error(error.message), status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:stock_item).permit(:quantity, :product_id)
  end
end
