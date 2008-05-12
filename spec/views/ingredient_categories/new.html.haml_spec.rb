require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredient_categories/new.html.haml" do
  include IngredientCategoriesHelper
  include IngredientCategorySpecHelper
  include ViewSpecHelper
  
  def call_render
    render "/ingredient_categories/new.html.haml", :layout => 'base'
  end
  
  describe "form block" do
    before(:each) do
      @ingredient_category = mock_model(IngredientCategory, :name => "")
      @ingredient_category.stub!(:new_record?).and_return(true)
      @errors = errors_mock_for(@ingredient_category)
    
      assigns[:ingredient_category] = @ingredient_category
    end

    it "should render new form" do
      call_render
      response.should have_tag("form[action=/ingredient_categories][method=post]") do
        with_tag("input#ingredient_category_name[name=?]", "ingredient_category[name]")
        with_tag("input[type=submit]")
      end
    end
    
    it "should have a link back to ingredient categories list" do
      call_render
      response.should have_tag("a[href=/ingredient_categories]")
    end
    
    it_should_behave_like "a page in the ingredients section"
  end
  
  describe "error explanation block" do
    it_should_behave_like "a new/edit page with model errors"
  end
end
