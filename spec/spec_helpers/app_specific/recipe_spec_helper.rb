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
end
