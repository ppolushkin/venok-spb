class OrdersController < ApplicationController

  skip_before_filter :authorize, :only => [:new, :create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new/[:basket_id]
  def new
    @order = Order.new
    basket_id = params[:basket_id].to_i
    @order.basket_id = basket_id
    @basket = Basket.find(basket_id)

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  def create
    @order = Order.new(params[:order])
    @basket = Basket.find(@order.basket_id)
    respond_to do |format|
      if @order.save
        session[:basket_id] = -1
        format.html { redirect_to '/order_submitted' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    render json: {:ok => true}
  end



end
