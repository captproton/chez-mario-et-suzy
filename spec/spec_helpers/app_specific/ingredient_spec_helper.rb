module IngredientSpecHelper
  def model_class
    Ingredient
  end
  
  def valid_attributes
    {
      :name => "My ingredient",
      :ingredient_category => mock_model(IngredientCategory)
    }
  end
  
  def required_fields
    [:name, :ingredient_category]
  end
  
  def attributes_for_errors_explanation
    {
      :name => "My ingredient",
      :unit_id => 1,
      :period_id => 1,
      :ingredient_category_id => 1
    }
  end
  
  def restful_resource_path
    {
      :base_path => "/ingredient_categories/24/ingredients",
      :controller => "ingredients",
      :nested_params => { :ingredient_category_id => "24" }
    }
  end
end
