require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipe_categories/edit.html.haml" do
  include RecipeCategoriesHelper
  include ViewSpecHelper
  
  before do
    @recipe_category = mock_model(RecipeCategory)
    @recipe_category.stub!(:name).and_return("Main course")
    @errors = errors_mock_for(@recipe_category)
    
    assigns[:recipe_category] = @recipe_category
  end

  it "should render edit form" do
    render "/recipe_categories/edit.html.haml"
    
    response.should have_tag("form[action=#{recipe_category_path(@recipe_category)}][method=post]") do
      with_tag('input#recipe_category_name[name=?]', "recipe_category[name]")
    end
  end
end
