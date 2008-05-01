module IngredientSpecHelper
  def model_class
    Ingredient
  end
  
  def valid_attributes
    {
      :name => "My ingredient",
      :unit => mock_model(Unit),
      :period => mock_model(Period),
      :ingredient_category => mock_model(IngredientCategory)
    }
  end
  
  # :unit and :period are required but they are automatically filled if empty
  def required_fields
    [:name, :ingredient_category]
  end
  
  def restful_resource_path
    {
      :base_path => "/ingredient_categories/24/ingredients",
      :controller => "ingredients",
      :nested_params => { :ingredient_category_id => "24" }
    }
  end
end
