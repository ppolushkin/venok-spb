Obelisk::Application.routes.draw do

  resources :feedback_mails
  get "feedback", :controller => "feedback_mails", :action => "new", :as => "feedback"
  post "send_feedback", :controller => "feedback", :action => "send_feedback", :as =>"send_feedback"

  get "search", :controller => "search", :action => "search", :as=>"search"

  controller :sessions do
    get 'login' => :show_login_form, :as => 'login'
    post 'login' => :log_in
    delete 'logout' => :log_out
  end

  get "ritual_venki", :controller => "store", :action => "show_venki", :as=>"venki"
  get "ritual_korsinu", :controller => "store", :action => "show_korsinu", :as=>"korsinu"
  get "may_9", :controller => "store", :action => "show_may_9", :as=>"may_9"
  get "novinki", :controller => "store", :action => "show_novinki", :as=>"novinki"
  get "buy", :controller => "store", :action => "buy", :as=>"buy"
  get "goods", :controller => "store", :action => "show_goods", :as=>"goods"
  get "venok/:id", :controller => "store", :action => "show_product"
  get "korzina/:id", :controller => "store", :action => "show_product"
  get "izdelie/:id", :controller => "store", :action => "show_product"

  resources :products

  resources :pages

  resources :admins

  get 'order/new/:basket_id', :controller=>"orders", :action => "new"
  resources :orders

  root :controller => "pages", :action => "show_by_page_ref", :page_ref => 'venok_main', :as => 'venok_main'

  get 'api/v1/basket', :controller => 'api/v1/basket', :action => 'index'
  get 'api/v1/basket/:id', :controller => 'api/v1/basket', :action => 'item_details'
  delete 'api/v1/basket/:id', :controller => 'api/v1/basket', :action => 'delete_item'
  put 'api/v1/basket', :controller => 'api/v1/basket', :action => 'put'

  put "/api/v1/depot", :controller => 'api/v1/depot', :action => 'put_items'


  get "basket", :controller => 'basket', :action=> 'index'

  get "depots", :controller => 'depots', :action=> 'index'
  get "depot/:id/add_items", :controller => 'depots', :action=> 'add_items'
  get "depot/:id/edit_items", :controller => 'depots', :action=> 'edit_items'


  resources :depot_items


  match ":page_ref", :controller => "pages", :action => "show_by_page_ref"

end
