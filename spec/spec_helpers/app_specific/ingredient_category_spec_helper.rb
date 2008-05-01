module IngredientCategorySpecHelper
  def model_class
    IngredientCategory
  end
  
  def valid_attributes
    {
      :name => "My ingredient category"
    }
  end
  
  def required_fields
    [:name]
  end
  
  def restful_resource_path
    {
      :base_path => "/ingredient_categories",
      :controller => "ingredient_categories"
    }
  end
end
