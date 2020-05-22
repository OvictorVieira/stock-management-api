class Api::V1::StoresController < ApplicationController

  include Paginator
  include ErrorHandler

  before_action :set_page, :set_items_per_page
  before_action :load_store, only: [:show, :update, :destroy]

  def index
    @all_stores = Store.all

    total_stores = @all_stores.count

    serialized_stores = StoreSerializer
                          .serialize_collection(paginate(@all_stores), @page, @per_page, total_stores)

    render json: serialized_stores
  end

  def show
    render json: @store
  end

  def create
    begin
      permitted = permitted_params

      store = Store.create!(permitted)

      render json: store, status: :created
      
    rescue ActiveRecord::RecordInvalid, StandardError => error

      render json: build_error(error.message), status: :unprocessable_entity
    end
  end

  def update
    permitted = permitted_params

    @store.update(permitted)

    render json: @store
  end

  def destroy
    @store.destroy
  end

  private

  def load_store
    begin
      @store = Store.find_by_id(params[:id])

      raise ::Stores::RecordNotFound.new(params[:id]) if @store.blank?

    rescue ::Stores::RecordNotFound => error

      render json: build_error(error.message), status: :not_found
    end
  end

  def permitted_params
    params.require(:store).permit(:name, :address)
  end
end
