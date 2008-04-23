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
end
