require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipes/edit.html.haml" do
  include RecipesHelper
  include ViewSpecHelper
  
  before do
    @recipe_category = mock_model(RecipeCategory)
    @recipe = mock_model(Recipe,
      :new_record? => false,
      :name => "Sauteed beef",
      :description => "Delicious",
      :directions => "Cook it",
      :recipe_category_id => 1
    )
    @errors = errors_mock_for(@recipe)
    
    assigns[:recipe_category] = @recipe_category
    assigns[:recipe] = @recipe
  end

  it "should render edit form" do
    render "/recipes/edit.html.haml"
    
    response.should have_tag("form[action=#{recipe_category_recipe_path(@recipe_category, @recipe)}][method=post]") do
      with_tag('input#recipe_name[name=?]', "recipe[name]")
      with_tag('textarea#recipe_description[name=?]', "recipe[description]")
      with_tag('textarea#recipe_directions[name=?]', "recipe[directions]")
    end
  end
end
