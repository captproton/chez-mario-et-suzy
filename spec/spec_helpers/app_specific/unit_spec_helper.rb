module UnitSpecHelper
  def model_class
    Unit
  end
  
  def valid_attributes
    {
      :name => 'Kilogrames',
      :abbreviation => 'kg'
    }
  end
  
  def required_fields
    [:name, :abbreviation]
  end
end
