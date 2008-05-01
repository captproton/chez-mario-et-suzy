class MeasuresController < ApplicationController
  layout 'base'
  
  before_filter :find_recipe_category_and_recipe
  before_filter :find_ingredients, :only => [:new, :edit]
  
  # GET /measures
  # GET /measures.xml
  def index
    @measures = @recipe.measures

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @measures }
    end
  end

  # No HTML view
  # GET /measures/1.xml
  def show
    @measure = Measure.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @measure }
    end
  end

  # GET /measures/new
  # GET /measures/new.xml
  def new
    @measure = Measure.new
    @measure.recipe = @recipe

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @measure }
    end
  end

  # GET /measures/1/edit
  def edit
    @measure = Measure.find(params[:id])
  end

  # POST /measures
  # POST /measures.xml
  def create
    @measure = Measure.new(params[:measure])
    @measure.recipe = @recipe

    respond_to do |format|
      if @measure.save
        flash[:notice] = l(:flash_notice_measure_created)
        format.html { redirect_to [ @recipe_category, @recipe ] }
        format.xml  { render :xml => @measure, :status => :created, :location => @measure }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @measure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /measures/1
  # PUT /measures/1.xml
  def update
    @measure = Measure.find(params[:id])

    respond_to do |format|
      if @measure.update_attributes(params[:measure])
        flash[:notice] = l(:flash_notice_measure_updated)
        format.html { redirect_to [ @recipe_category, @recipe ] }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @measure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /measures/1
  # DELETE /measures/1.xml
  def destroy
    @measure = Measure.find(params[:id])
    @measure.destroy

    flash[:notice] = l(:flash_notice_measure_deleted)
    respond_to do |format|
      format.html { redirect_to [ @recipe_category, @recipe ] }
      format.xml  { head :ok }
    end
  end
  
  protected
    def find_recipe_category_and_recipe
      @recipe_category = RecipeCategory.find(params[:recipe_category_id])
      @recipe = Recipe.find(params[:recipe_id])
    end
    
    def find_ingredients
      @ingredients = Ingredient.find(:all)
    end
end
