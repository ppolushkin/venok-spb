class DepotsController < ApplicationController

  # GET /depots
  def index
    @depots = Depot.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def add_items

  end

  def edit_items

  end

end
