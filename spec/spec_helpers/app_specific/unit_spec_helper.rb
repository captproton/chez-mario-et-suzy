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
  
  def restful_resource_path
    {
      :base_path => "/units",
      :controller => "units"
    }
  end
end
