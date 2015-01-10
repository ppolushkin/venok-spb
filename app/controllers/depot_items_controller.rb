class DepotItemsController < ApplicationController
  # GET /depot_items
  # GET /depot_items.json
  def index
    all_items = DEPOT.depot_items.all

    all_items.delete_if do |item|
      if item.product == nil
        item.delete
        true
      end
    end

    @depot_items = all_items.sort do |a,b|
      a.product.name <=> b.product.name
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /depot_items/1
  # GET /depot_items/1.json
  def show
    @depot_item = DepotItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @depot_item }
    end
  end

  # GET /depot_items/new
  # GET /depot_items/new.json
  def new
    @depot_item = DepotItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @depot_item }
    end
  end

  # GET /depot_items/1/edit
  def edit
    @depot_item = DepotItem.find(params[:id])
  end

  # POST /depot_items
  # POST /depot_items.json
  def create
    @depot_item = DepotItem.new(params[:depot_item])
    @depot_item.depot_id = DEPOT.id

    respond_to do |format|
      if @depot_item.save
        format.html { redirect_to @depot_item, notice: 'Depot item was successfully created.' }
        format.json { render json: @depot_item, status: :created, location: @depot_item }
      else
        format.html { render action: "new" }
        format.json { render json: @depot_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /depot_items/1
  # PUT /depot_items/1.json
  def update
    @depot_item = DepotItem.find(params[:id])

    respond_to do |format|
      if @depot_item.update_attributes(params[:depot_item])
        format.html { redirect_to @depot_item, notice: 'Depot item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @depot_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /depot_items/1
  # DELETE /depot_items/1.json
  def destroy
    @depot_item = DepotItem.find(params[:id])
    @depot_item.destroy

    respond_to do |format|
      format.html { redirect_to depot_items_url }
      format.json { head :no_content }
    end
  end
end
