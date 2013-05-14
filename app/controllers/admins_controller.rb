class AdminsController < ApplicationController
  # GET /admins
  # GET /admins.xml
  def index
    @admins = Admin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admins }
    end
  end

  # GET /admins/new
  # GET /admins/new.xml
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admins
  # POST /admins.xml
  def create
    @admin = Admin.new(params[:admin])
    respond_to do |format|
      if @admin.save
        format.html { redirect_to(admins_url, :notice => 'Admin was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.xml
  def update
    @admin = Admin.find(params[:id])

    @admin.email=params[:admin][:email]
    @admin.password=params[:admin][:password]
    respond_to do |format|
      if @admin.save
        format.html { redirect_to(admins_url, :notice => 'Admin was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.xml
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    render json: {:ok => true}
  end
end
