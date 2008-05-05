module MeasureSpecHelper
  def model_class
    Measure
  end
  
  def valid_attributes
    {
      :number => 3,
      :recipe => mock_model(Recipe),
      :ingredient => mock_model(Ingredient)
    }
  end
  
  # :number is required but has a default value
  def required_fields
    [:recipe, :ingredient]
  end
  
  def attributes_for_errors_explanation
    {
      :number => 3,
      :recipe_id => 1,
      :ingredient_id => 1
    }
  end
  
  def restful_resource_path
    {
      :base_path => "/recipe_categories/24/recipes/32/measures",
      :controller => "measures",
      :nested_params => { :recipe_category_id => "24", :recipe_id => "32" }
    }
  end
end
