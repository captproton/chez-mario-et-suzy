class IngredientsController < ApplicationController
  layout 'base'
  
  before_filter :find_ingredient_category
  before_filter :find_units_and_periods, :only => [:new, :edit, :create, :update]
  
  # GET /ingredients
  # GET /ingredients.xml
  def index
    @ingredients = @ingredient_category.ingredients.sort_by(&:name)

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @ingredients }
    end
  end

  # No HTML view
  # GET /ingredients/1.xml
  def show
    @ingredient = Ingredient.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @ingredient }
    end
  end

  # GET /ingredients/new
  # GET /ingredients/new.xml
  def new
    @ingredient = Ingredient.new
    @ingredient.ingredient_category = @ingredient_category

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @ingredient }
    end
  end

  # GET /ingredients/1/edit
  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  # POST /ingredients
  # POST /ingredients.xml
  def create
    @ingredient = Ingredient.new(params[:ingredient])
    @ingredient.ingredient_category = @ingredient_category

    respond_to do |format|
      if @ingredient.save
        flash[:notice] = l(:flash_notice_ingredient_created)
        format.html { redirect_to [ @ingredient_category, Ingredient.new ] }
        format.xml  { render :xml => @ingredient, :status => :created, :location => @ingredient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ingredients/1
  # PUT /ingredients/1.xml
  def update
    @ingredient = Ingredient.find(params[:id])

    respond_to do |format|
      if @ingredient.update_attributes(params[:ingredient])
        flash[:notice] = l(:flash_notice_ingredient_updated)
        format.html { redirect_to [ @ingredient_category, Ingredient.new ] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.xml
  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy

    flash[:notice] = l(:flash_notice_ingredient_deleted)
    respond_to do |format|
      format.html { redirect_to [ @ingredient_category, Ingredient.new ] }
      format.xml  { head :ok }
    end
  end
  
  protected
    def find_ingredient_category
      @ingredient_category = IngredientCategory.find(params[:ingredient_category_id])
    end
    
    def find_units_and_periods
      @units = Unit.find(:all)
      @periods = Period.find(:all)
    end
end
