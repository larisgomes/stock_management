Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :stores
      resources :products
      resources :stock_items, only: [:create, :index]
      post '/:operation/:stock_item_id/:amount', to: 'stock_items#update'
    end
  end
end
