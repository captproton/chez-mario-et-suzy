require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredient_categories/new.html.haml" do
  include IngredientCategoriesHelper
  include ViewSpecHelper
  
  before(:each) do
    @ingredient_category = mock_model(IngredientCategory, :name => "")
    @ingredient_category.stub!(:new_record?).and_return(true)
    @errors = errors_mock_for(@ingredient_category)
    
    assigns[:ingredient_category] = @ingredient_category
  end

  it "should render new form" do
    render "/ingredient_categories/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", ingredient_categories_path) do
      with_tag("input#ingredient_category_name[name=?]", "ingredient_category[name]")
    end
  end
end
