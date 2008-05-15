class IngredientCategoriesController < ApplicationController
  layout 'base'
  
  # GET /ingredient_categories
  # GET /ingredient_categories.xml
  def index
    # Paginates if HTML, returns all if XML
    respond_to do |format|
      format.html do
        @ingredient_categories = IngredientCategory.paginate(:page => params[:page], :order => 'name', :per_page => 5)
      end # index.html.haml
      format.xml do
        @ingredient_categories = IngredientCategory.find(:all, :order => 'name')
        render :xml => @ingredient_categories
      end
    end
  end

  # No HTML view
  # GET /ingredient_categories/1.xml
  def show
    @ingredient_category = IngredientCategory.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @ingredient_category }
    end
  end

  # GET /ingredient_categories/new
  # GET /ingredient_categories/new.xml
  def new
    @ingredient_category = IngredientCategory.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @ingredient_category }
    end
  end

  # GET /ingredient_categories/1/edit
  def edit
    @ingredient_category = IngredientCategory.find(params[:id])
  end

  # POST /ingredient_categories
  # POST /ingredient_categories.xml
  def create
    @ingredient_category = IngredientCategory.new(params[:ingredient_category])

    respond_to do |format|
      if @ingredient_category.save
        flash[:notice] = l(:flash_notice_ingredient_category_created)
        format.html { redirect_to IngredientCategory.new }
        format.xml  { render :xml => @ingredient_category, :status => :created, :location => @ingredient_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ingredient_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ingredient_categories/1
  # PUT /ingredient_categories/1.xml
  def update
    @ingredient_category = IngredientCategory.find(params[:id])

    respond_to do |format|
      if @ingredient_category.update_attributes(params[:ingredient_category])
        flash[:notice] = l(:flash_notice_ingredient_category_updated)
        format.html { redirect_to IngredientCategory.new }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ingredient_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredient_categories/1
  # DELETE /ingredient_categories/1.xml
  def destroy
    @ingredient_category = IngredientCategory.find(params[:id])
    
    if @ingredient_category.destroy
      flash[:notice] = l(:flash_notice_ingredient_category_deleted)
    else
      flash[:notice] = l(:flash_notice_ingredient_category_non_empty)
    end
    
    respond_to do |format|
      format.html { redirect_to IngredientCategory.new }
      format.xml  { head :ok }
    end
  end
end
