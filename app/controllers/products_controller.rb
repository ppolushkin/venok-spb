class ProductsController < ApplicationController

  include ProductsHelper

  # GET /products
  # GET /products.xml
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    upload_tmp_images_from_hash_and_fix_hash(params[:product])
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        commit_tmp_uploaded_images(params[:product][:article].to_s)
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        delete_tmp_uploaded_images(params[:product][:article].to_s)
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    upload_tmp_images_from_hash_and_fix_hash(params[:product])
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        commit_tmp_uploaded_images(params[:product][:article].to_s)
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        delete_tmp_uploaded_images(params[:product][:article].to_s)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    delete_uploaded_images(@product.article)
    @product.destroy

    render json: {:ok => true}
  end
end
