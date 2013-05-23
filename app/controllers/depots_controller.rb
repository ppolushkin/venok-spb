class DepotsController < ApplicationController
  # GET /depots
  # GET /depots.json
  def index
    @depots = Depot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @depots }
    end
  end

  # GET /depots/1
  # GET /depots/1.json
  def show
    @depot = Depot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @depot }
    end
  end

  # GET /depots/new
  # GET /depots/new.json
  def new
    @depot = Depot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @depot }
    end
  end

  # GET /depots/1/edit
  def edit
    @depot = Depot.find(params[:id])
  end

  # POST /depots
  # POST /depots.json
  def create
    @depot = Depot.new(params[:depot])

    respond_to do |format|
      if @depot.save
        format.html { redirect_to @depot, notice: 'Depot was successfully created.' }
        format.json { render json: @depot, status: :created, location: @depot }
      else
        format.html { render action: "new" }
        format.json { render json: @depot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /depots/1
  # PUT /depots/1.json
  def update
    @depot = Depot.find(params[:id])

    respond_to do |format|
      if @depot.update_attributes(params[:depot])
        format.html { redirect_to @depot, notice: 'Depot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @depot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /depots/1
  # DELETE /depots/1.json
  def destroy
    @depot = Depot.find(params[:id])
    @depot.destroy

    respond_to do |format|
      format.html { redirect_to depots_url }
      format.json { head :no_content }
    end
  end
end
