class RecipeCategoriesController < ApplicationController
  layout 'base'
  
  # GET /recipe_categories
  # GET /recipe_categories.xml
  def index
    respond_to do |format|
      format.html do
        @recipe_categories = RecipeCategory.paginate(:page => params[:page], :order => 'name', :per_page => 5)
      end # index.html.haml
      format.xml do
        @recipe_categories = RecipeCategory.find(:all, :order => 'name')
        render :xml => @recipe_categories
      end
    end
  end

  # No HTML view
  # GET /recipe_categories/1.xml
  def show
    @recipe_category = RecipeCategory.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @recipe_category }
    end
  end

  # GET /recipe_categories/new
  # GET /recipe_categories/new.xml
  def new
    @recipe_category = RecipeCategory.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @recipe_category }
    end
  end

  # GET /recipe_categories/1/edit
  def edit
    @recipe_category = RecipeCategory.find(params[:id])
  end

  # POST /recipe_categories
  # POST /recipe_categories.xml
  def create
    @recipe_category = RecipeCategory.new(params[:recipe_category])

    respond_to do |format|
      if @recipe_category.save
        flash[:notice] = l(:flash_notice_recipe_category_created)
        format.html { redirect_to RecipeCategory.new }
        format.xml  { render :xml => @recipe_category, :status => :created, :location => @recipe_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipe_categories/1
  # PUT /recipe_categories/1.xml
  def update
    @recipe_category = RecipeCategory.find(params[:id])

    respond_to do |format|
      if @recipe_category.update_attributes(params[:recipe_category])
        flash[:notice] = l(:flash_notice_recipe_category_updated)
        format.html { redirect_to RecipeCategory.new }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_categories/1
  # DELETE /recipe_categories/1.xml
  def destroy
    @recipe_category = RecipeCategory.find(params[:id])
    
    if @recipe_category.destroy
      flash[:notice] = l(:flash_notice_recipe_category_deleted)
    else
      flash[:notice] = l(:flash_notice_recipe_category_non_empty)
    end
    
    respond_to do |format|
      format.html { redirect_to RecipeCategory.new }
      format.xml  { head :ok }
    end
  end
end
