require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipe_categories/index.html.haml" do
  include RecipeCategoriesHelper
  include ViewSpecHelper
  
  before(:each) do
    @recipe_category_1 = mock_model(RecipeCategory, :id => 1, :to_param => "1")
    @recipe_category_1.should_receive(:name).and_return("Main course")
    @recipes_1 = mock("recipes 1")
    @recipes_1.should_receive(:size).and_return(21)
    @recipe_category_1.should_receive(:recipes).and_return(@recipes_1)
    
    @recipe_category_2 = mock_model(RecipeCategory, :id => 2, :to_param => "2")
    @recipe_category_2.should_receive(:name).and_return("Desserts")
    @recipes_2 = mock("recipes 2")
    @recipes_2.should_receive(:size).and_return(33)
    @recipe_category_2.should_receive(:recipes).and_return(@recipes_2)

    assigns[:recipe_categories] = [@recipe_category_1, @recipe_category_2]
  end

  def call_render
    render "/recipe_categories/index.html.haml", :layout => 'base'
  end

  it "should render list of recipe categories with their number of recipes and links to recipes" do
    call_render
    response.should have_tag("div#recipe_category_1.recipe_category") do
      with_tag("h3>a[href=/recipe_categories/1/recipes]", /Main course/)
      with_tag("span.count", /21/)
    end
    response.should have_tag("div#recipe_category_2.recipe_category") do
      with_tag("h3>a[href=/recipe_categories/2/recipes]", /Desserts/)
      with_tag("span.count", /33/)
    end
  end
  
  it "should render an edit link for each recipe category" do
    call_render
    response.should have_tag("div#recipe_category_1") do
      with_tag("a[href=/recipe_categories/1/edit]")
    end
    response.should have_tag("div#recipe_category_2") do
      with_tag("a[href=/recipe_categories/2/edit]")
    end
  end
  
  it "should render a delete link for each recipe category" do
    call_render
    response.should have_tag("div#recipe_category_1") do
      with_tag("a[href=/recipe_categories/1][onclick=?]", delete_link_pattern)
    end
    response.should have_tag("div#recipe_category_2") do
      with_tag("a[href=/recipe_categories/2][onclick=?]", delete_link_pattern)
    end
  end
  
  it "should have a link for creating a new recipe category" do
    call_render
    response.should have_tag("a[href=/recipe_categories/new]")
  end
  
  it_should_behave_like "a page with a flash notice"
end
