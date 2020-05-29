Rails.application.routes.draw do

  scope :api do
    scope :v1 do

      devise_for :stores
    end
  end

  namespace :api do
    namespace :v1 do

      resources :products

      scope :stock_items do

        post '/add_item', to: 'stock_items#add_item', as: :stock_items_add_item
        post '/remove_item', to: 'stock_items#remove_item', as: :stock_items_remove_item
      end
    end
  end

end
