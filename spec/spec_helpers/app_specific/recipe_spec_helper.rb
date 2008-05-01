module RecipeSpecHelper
  def model_class
    Recipe
  end
  
  def valid_attributes
    {
      :name => "My recipe",
      :description => "Beautiful description",
      :directions => "Wonderful directions",
      :recipe_category => mock_model(RecipeCategory)
    }
  end
  
  def required_fields
    [:name, :description, :directions, :recipe_category]
  end
  
  def restful_resource_path
    {
      :base_path => "/recipe_categories/24/recipes",
      :controller => "recipes",
      :nested_params => { :recipe_category_id => "24" }
    }
  end
end
