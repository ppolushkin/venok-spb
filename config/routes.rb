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
  get "calc", :controller => "store", :action => "calc", :as=>"calc"
  get "goods", :controller => "store", :action => "show_goods", :as=>"goods"
  post "set_number_of_product_in_basket", :controller => "store", :action => "set_number_of_product_in_basket", :as=>"set_number_of_product_in_basket"

  resources :products

  resources :pages

  resources :admins

  match ":page_ref", :controller => "pages", :action => "show_by_page_ref"

  root :controller => "pages", :action => "show_by_page_ref", :page_ref => 'about_us', :as => 'about_us'

end
