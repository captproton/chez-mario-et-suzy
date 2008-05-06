require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipes/new.html.haml" do
  include RecipesHelper
  include RecipeSpecHelper
  include ViewSpecHelper

  def call_render
    render "/recipes/new.html.haml", :layout => 'base'
  end

  describe "form block" do
    before(:each) do
      @recipe_category = mock_model(RecipeCategory, :id => 1, :to_param => "1")
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
      call_render
      response.should have_tag("form[action=/recipe_categories/1/recipes][method=post]") do
        with_tag("input#recipe_name[name=?]", "recipe[name]")
        with_tag("textarea#recipe_description[name=?]", "recipe[description]")
        with_tag("textarea#recipe_directions[name=?]", "recipe[directions]")
        with_tag('input[type=submit]')
      end
    end
    
    it "should have a link back to recipe categories list" do
      call_render
      response.should have_tag("a[href=/recipe_categories]")
    end
    
    it_should_behave_like "a page in the recipes section"
  end
  
  describe "error explanation block" do
    before(:each) { assigns[:recipe_category] = mock_model(RecipeCategory) }
    it_should_behave_like "a new/edit page with model errors"
  end
end
