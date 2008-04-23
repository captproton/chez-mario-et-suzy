module RecipeCategorySpecHelper
  def model_class
    RecipeCategory
  end
  
  def valid_attributes
    {
      :name => "My recipe category"
    }
  end
  
  def required_fields
    [:name]
  end
end
