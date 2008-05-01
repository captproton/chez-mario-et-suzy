module ViewSpecHelper
  def errors_mock_for(model)
    errors = mock("errors", :null_object => true)
    errors.stub!(:empty?).and_return(true)
    model.stub!(:errors).and_return(errors)
    errors
  end
end
