require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipes/new.html.haml" do
  include RecipesHelper
  include ViewSpecHelper
  
  before(:each) do
    @recipe_category = mock_model(RecipeCategory)
    @recipe = mock_model(Recipe,
      :new_record? => true,
      :name => "",
      :description => "",
      :directions => "",
      :recipe_category_id => 1
    )
    @errors = errors_mock_for(@recipe)
    
    assigns[:recipe_category] = @recipe_category
    assigns[:recipe] = @recipe
  end

  it "should render new form" do
    render "/recipes/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", recipe_category_recipes_path(@recipe_category)) do
      with_tag("input#recipe_name[name=?]", "recipe[name]")
      with_tag("textarea#recipe_description[name=?]", "recipe[description]")
      with_tag("textarea#recipe_directions[name=?]", "recipe[directions]")
    end
  end
end
