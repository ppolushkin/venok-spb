class PagesController < ApplicationController

  skip_before_filter :authorize, :only => [:show_by_page_ref]

  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.find_all_by_application_name(APPLICATION_NAME)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show_by_page_ref
    @page = Page.first(conditions: [ 'lower(reference) = ?', params[:page_ref].downcase ])

    if @page == nil
      redirect_to :action => "new", :page_ref => params[:page_ref]
    else
      respond_to do |format|
        format.html # show.html.erb
      end
    end
  end

  #get /clean
  def show_clean_page
    @removed_baskets = 0
    Basket.all.each() do |b|
      if b.order.nil? && (b.created_at < (DateTime.now - 1.day))
        @removed_baskets = @removed_baskets + 1
        b.destroy
      end
    end
    respond_to do |format|
      format.html # show_clean_page.html.erb
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new
    if params!=nil && params[:page_ref]!=nil
      @page.reference=params[:page_ref]
    end
    @revision = Revision.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /pages/1/edit
  def edit
    @page     = Page.find(params[:id])
    @revision = @page.revisions.last || Revision.new
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page     = Page.new(params[:page])
    @revision = Revision.new(params[:revision])
    respond_to do |format|
      page_saved = @page.save
      @revision.update_attribute('page_id', @page.id)
      if page_saved && @revision.save
        format.html { redirect_to('/' + @page.reference, :notice => 'Page was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page     = Page.find(params[:id])
    @revision = Revision.new(params[:revision])
    @revision.update_attribute('page_id', @page.id)
    respond_to do |format|
      if @page.update_attributes(params[:page]) && @revision.save
        format.html { redirect_to('/' + @page.reference, :notice => 'Page was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])

    @page.revisions.each do |revision|
      revision.destroy
    end

    @page.destroy

    render json: {:ok => true}
  end
end
