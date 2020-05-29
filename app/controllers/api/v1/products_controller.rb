class Api::V1::ProductsController < ApplicationController

  before_action :set_page, :set_items_per_page, only: :index
  before_action :load_product, only: [:show, :update, :destroy]

  def index
    all_products = current_store.products

    total_products = all_products.count

    serialized_products = ProductSerializer
                          .serialize_collection(paginate(all_products),
                                                @page,
                                                @per_page,
                                                total_products)

    render json: serialized_products
  end

  def show
    render json: @product
  end

  def create
    begin
      permitted = permitted_params

      product = Products::ProductService.create(name: permitted[:name],
                                                cost_price: permitted[:cost_price],
                                                store: current_store)

      render json: product, status: :created

    rescue ActiveRecord::RecordInvalid, StandardError => error

      render json: build_error(error.message), status: :unprocessable_entity
    end
  end

  def update
    permitted = permitted_params

    @product.update(permitted)

    render json: @product
  end

  def destroy
    @product.destroy
  end

  private

  def load_product
    begin
      @product = Product.find_by_id(params[:id])

      raise Products::RecordNotFound.new(params[:id]) if @product.blank?

    rescue Products::RecordNotFound => error

      render json: build_error(error.message), status: :not_found
    end
  end

  def permitted_params
    params.require(:product).permit(:name, :cost_price)
  end
end
