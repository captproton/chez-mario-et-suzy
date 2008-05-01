class IngredientCategoriesController < ApplicationController
  layout 'base'
  
  # GET /ingredient_categories
  # GET /ingredient_categories.xml
  def index
    @ingredient_categories = IngredientCategory.find(:all)

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @ingredient_categories }
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
    @ingredient_category.destroy

    flash[:notice] = l(:flash_notice_ingredient_category_deleted)
    respond_to do |format|
      format.html { redirect_to IngredientCategory.new }
      format.xml  { head :ok }
    end
  end
end
