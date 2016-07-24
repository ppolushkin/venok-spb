# coding: utf-8

class StoreController < ApplicationController

  include StoreHelper

  skip_before_filter :authorize

  #GET /ritual_venki
  #GET /ritual_venki?filter=new
  #GET /ritual_venki?filter=military&sort=price
  #GET /ritual_venki?filter=big
  #GET /ritual_venki?filter=middle
  #GET /ritual_venki?filter=small
  #GET /ritual_venki?filter=in_store
  def show_venki
    get_products "В", params
    if params[:filter] == 'military'
      render 'show_military_venki'
    else
      render 'show_venki'
    end
  end

  def show_natural_venki
    get_products "Ж", params
  end

  def show_korsinu
    get_products "К", params
  end

  def show_goods
    get_products "И", params
  end

  def show_flowers
    get_products "Ц", params
  end

  def show_product
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  protect_from_forgery

  def get_products(product_type, params)
    if (params[:filter] == "in_store")
      @products = DEPOT.get_availiable_products product_type
    else
      conditions = "article like '#{product_type}%' "
      conditions += filter(params[:filter]) if params[:filter]
      @products = Product.all :conditions => conditions, :order => sort(params[:sort])
    end
  end

  def show_all_products(key)
    Product.all :conditions => "article like '#{key}%'", :order => "price desc"
  end


end
