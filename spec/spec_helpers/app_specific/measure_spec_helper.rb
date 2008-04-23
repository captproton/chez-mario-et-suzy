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
end
