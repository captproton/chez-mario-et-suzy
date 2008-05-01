module PeriodSpecHelper
  def model_class
    Period
  end
  
  def valid_attributes
    {
      :start_month => 1,
      :end_month => 12
    }
  end
  
  def required_fields
    [:start_month, :end_month]
  end
  
  def restful_resource_path
    {
      :base_path => "/periods",
      :controller => "periods"
    }
  end
end
