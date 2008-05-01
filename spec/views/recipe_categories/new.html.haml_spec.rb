require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipe_categories/new.html.haml" do
  include RecipeCategoriesHelper
  include ViewSpecHelper
  
  before(:each) do
    @recipe_category = mock_model(RecipeCategory, :name => "")
    @recipe_category.stub!(:new_record?).and_return(true)
    @errors = errors_mock_for(@recipe_category)
    
    assigns[:recipe_category] = @recipe_category
  end

  it "should render new form" do
    render "/recipe_categories/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", recipe_categories_path) do
      with_tag("input#recipe_category_name[name=?]", "recipe_category[name]")
    end
  end
end
