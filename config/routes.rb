Rails.application.routes.draw do

  

   
namespace :admin do
  resources :items, only: [:index,:show,:new,:create,:edit,:update]
  resources :customers, only: [:index, :show, :update, :edit]
  resources :orders, only: [:show,]
end

scope module: :public do
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resources :items, only: [:index,:show]  
    get 'customers/show'
    get 'customers/edit'
    patch 'customers/update'
    get 'customers/confirm'
    patch '/customers/unsubscribe'
    
    post 'orders/confirm'
    get 'orders/complete'
    resources :orders, only: [:index, :create, :new, :show]
    
    

end

get 'homes/about'
get 'homes/top'
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: "homes#top"
end
