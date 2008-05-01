class RecipesController < ApplicationController
  layout 'base'
  
  before_filter :find_recipe_category
  
  # GET /recipes
  # GET /recipes.xml
  def index
    @recipes = @recipe_category.recipes

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.xml
  def show
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.xml
  def new
    @recipe = Recipe.new
    @recipe.recipe_category = @recipe_category

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.recipe_category = @recipe_category

    respond_to do |format|
      if @recipe.save
        flash[:notice] = l(:flash_notice_recipe_created)
        format.html { redirect_to [ @recipe_category, @recipe ] }
        format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.xml
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        flash[:notice] = l(:flash_notice_recipe_updated)
        format.html { redirect_to [ @recipe_category, @recipe ] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    flash[:notice] = l(:flash_notice_recipe_deleted)
    respond_to do |format|
      format.html { redirect_to [ @recipe_category, Recipe.new ] }
      format.xml  { head :ok }
    end
  end
  
  protected
    def find_recipe_category
      @recipe_category = RecipeCategory.find(params[:recipe_category_id])
    end
end
