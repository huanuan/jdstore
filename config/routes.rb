Rails.application.routes.draw do
  devise_for :users
  root 'products#index'

    namespace :admin do
      resources :products
      resources :orders do
        member do
          post :cancell_order
          post :return_good
          post :ship
          post :deliver
          post :refund
        end
      end

      resources :users do
        member do
          post :admin
          post :user
        end
      end
    end


    namespace :account do
      resources :orders do
        member do
          post :appl_cancell_order
          post :appl_return_good
          post :pay_with_wechat
          post :pay_with_alipay
        end
      end
    end


    resources :products do
      member do
        post :add_to_cart
      end
    end

    resources :carts do
      collection do
        post :checkout
      end
    end

    resources :carts do
      member do
        post :clear_cart
      end
    end

   resources :cart_items do
     member do
       post :change_quantity
       post :clear
       post :add_item
       post :des_item
     end
   end


  resources :orders do
    member do
      post :pay_with_wechat
      post :pay_with_alipay
    end
  end

  namespace :account do
    resources :orders
  end

end
