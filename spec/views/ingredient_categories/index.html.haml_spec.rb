require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredient_categories/index.html.haml" do
  include IngredientCategoriesHelper
  include ViewSpecHelper
  
  before(:each) do
    ingredient_category_1 = mock_model(IngredientCategory, :id => 1, :to_param => "1")
    ingredient_category_1.should_receive(:name).and_return("Vegetables")
    ingredients_1 = mock("ingredients 1")
    ingredients_1.should_receive(:size).and_return(3)
    ingredient_category_1.should_receive(:ingredients).and_return(ingredients_1)
    
    ingredient_category_2 = mock_model(IngredientCategory, :id => 2, :to_param => "2")
    ingredient_category_2.should_receive(:name).and_return("Meat")
    ingredients_2 = mock("ingredients 2")
    ingredients_2.should_receive(:size).and_return(7)
    ingredient_category_2.should_receive(:ingredients).and_return(ingredients_2)

    assigns[:ingredient_categories] = [ingredient_category_1, ingredient_category_2]
  end
  
  def call_render
    render "/ingredient_categories/index.html.haml", :layout => 'base'
  end

  it "should render list of ingredient categories with their number of ingredients and links to ingredients" do
    call_render
    response.should have_tag("div#ingredient_category_1.ingredient_category") do
      with_tag("h3>a[href=/ingredient_categories/1/ingredients]", /Vegetables/)
      with_tag("span.count", /3/)
    end
    response.should have_tag("div#ingredient_category_2.ingredient_category") do
      with_tag("h3>a[href=/ingredient_categories/2/ingredients]", /Meat/)
      with_tag("span.count", /7/)
    end
  end
  
  it "should render an edit link for each ingredient categories" do
    call_render
    response.should have_tag("div#ingredient_category_1") do
      with_tag("a[href=/ingredient_categories/1/edit]")
    end
    response.should have_tag("div#ingredient_category_2") do
      with_tag("a[href=/ingredient_categories/2/edit]")
    end
  end
  
  it "should render a delete link for each ingredient categories" do
    call_render
    response.should have_tag("div#ingredient_category_1") do
      with_tag("a[href=/ingredient_categories/1][onclick=?]", delete_link_pattern)
    end
    response.should have_tag("div#ingredient_category_2") do
      with_tag("a[href=/ingredient_categories/2][onclick=?]", delete_link_pattern)
    end
  end
  
  it "should have a link for creating a new ingredient category" do
    call_render
    response.should have_tag("a[href=/ingredient_categories/new]")
  end
  
  it "should have a link to units list" do
    call_render
    response.should have_tag("a[href=/units]")
  end
  
  it "should have a link to periods list" do
    call_render
    response.should have_tag("a[href=/periods]")
  end
  
  it_should_behave_like "a page in the ingredients section"
  
  it_should_behave_like "a page with a flash notice"
end
