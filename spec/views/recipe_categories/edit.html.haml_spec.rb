require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipe_categories/edit.html.haml" do
  include RecipeCategoriesHelper
  include RecipeCategorySpecHelper
  include ViewSpecHelper
  
  def call_render
    render "/recipe_categories/edit.html.haml", :layout => 'base'
  end
  
  describe "form block" do
    before do
      @recipe_category = mock_model(RecipeCategory, :id => 1, :to_param => "1")
      @recipe_category.stub!(:name).and_return("Main course")
      @errors = errors_mock_for(@recipe_category)
    
      assigns[:recipe_category] = @recipe_category
    end

    it "should render edit form" do
      call_render
      response.should have_tag("form[action=/recipe_categories/1][method=post]") do
        with_tag('input#recipe_category_name[name=?]', "recipe_category[name]")
        with_tag('input[type=submit]')
      end
    end
    
    it "should have a link back to recipe categories list" do
      call_render
      response.should have_tag("a[href=/recipe_categories]")
    end
  end
  
  describe "errors explanation block" do
    it_should_behave_like "a new/edit page with model errors"
  end
end
