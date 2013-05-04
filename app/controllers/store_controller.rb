# coding: utf-8

class StoreController < ApplicationController

  include StoreHelper

  skip_before_filter :authorize

  def show_venki
    show_products "В", params[:sort]
  end

  def show_korsinu
    show_products "К", params[:sort]
  end

  def show_goods
    show_products "И", params[:sort]
  end

  def show_may_9
    @products = Product.paginate :page=>params[:page], :per_page => 500, :conditions => "may9 <> '0'", :order => "price desc"
  end

  def show_novinki
    dt = Date.today - 6.months
    @products = Product.paginate :page=>params[:page], :per_page => 500, :conditions => "created_at > '#{dt}'", :order => "created_at desc"
  end

  def calc
    @venki = show_all_products "В"
    @korsinu = show_all_products "К"
    @basket = current_basket
  end

  def set_number_of_product_in_basket
    @venki = show_all_products "В"
    @basket = current_basket
    product = Product.find_by_article params[:article]
    @basket.set_number_of_product(product, params[:selected_product_number].to_i)

    respond_to do |format|
      format.html { redirect_to :calc }
      format.js
    end
  end

  protect_from_forgery

  def show_products(key, sort)
    if sort == nil
      order = "price desc"
    else
      order = "created_at desc"
    end

    @products = Product.paginate :page=>params[:page], :per_page => 500, :conditions => "article like '#{key}%'", :order => order
  end

  def show_all_products(key)
    Product.all :conditions => "article like '#{key}%'", :order => "price desc"
  end

  def current_basket
    Basket.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound
    basket = Basket.create
    session[:basket_id] = basket.id
    basket
  end

  private

end
