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
  
  def restful_resource_path
    {
      :base_path => "/recipe_categories",
      :controller => "recipe_categories"
    }
  end
end
