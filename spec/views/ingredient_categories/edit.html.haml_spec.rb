require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredient_categories/edit.html.haml" do
  include IngredientCategoriesHelper
  include ViewSpecHelper
  
  before do
    @ingredient_category = mock_model(IngredientCategory, :name => "Main course")
    @errors = errors_mock_for(@ingredient_category)
    assigns[:ingredient_category] = @ingredient_category
  end

  it "should render edit form" do
    render "/ingredient_categories/edit.html.haml"
    
    response.should have_tag("form[action=#{ingredient_category_path(@ingredient_category)}][method=post]") do
      with_tag('input#ingredient_category_name[name=?]', "ingredient_category[name]")
    end
  end
end


