require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/new.html.erb" do
  include IngredientsHelper
  include ViewSpecHelper
  
  before(:each) do
    @ingredient_category = mock_model(IngredientCategory, :to_param => "1")
    @ingredient = mock_model(Ingredient, :name => "", :unit_id => 1, :ingredient_category_id => 1, :period_id => 1)
    @ingredient.stub!(:new_record?).and_return(true)
    @errors = errors_mock_for(@ingredient)

    assigns[:ingredient] = @ingredient
    assigns[:ingredient_category] = @ingredient_category
    assigns[:units] = []
    assigns[:periods] = []
  end

  it "should render new form" do
    render "/ingredients/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", ingredient_category_ingredients_path(@ingredient_category)) do
      with_tag("input#ingredient_name[name=?]", "ingredient[name]")
    end
  end
end
