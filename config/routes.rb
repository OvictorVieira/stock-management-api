Rails.application.routes.draw do

  scope :api do
    scope :v1 do

      devise_for :stores
    end
  end

  namespace :api do
    namespace :v1 do

      resources :products, except: :index
    end
  end

end
