describe "a new/edit page with model errors", :shared => true do
  before(:each) do
    @model = mock_model(model_class, :current_language => 'en')
    attributes = begin
      attributes_for_errors_explanation
    rescue
      valid_attributes
    end
    attributes.each do |attribute, value|
      @model.stub!(attribute).and_return(value)
    end
    assigns[model_class.name.underscore.to_sym] = @model
  end
  
  it "should render an error text for each field with an error" do
    @errors = build_errors(@model, *valid_attributes.keys)
    @model.stub!(:errors).and_return(@errors)
    call_render
    response.should have_tag("div#errorExplanation.errorExplanation") do
      # There should be as many "li" as attributes, +1 for an error on base
      with_tag("li", valid_attributes.size + 1)
    end
  end
  
  it "should not render error explanation when there is no errors" do
    @errors = build_errors(@model)
    @model.stub!(:errors).and_return(@errors)
    call_render
    response.should_not have_tag("div#errorExplanation.errorExplanation")
  end
  
  # Build an ActiveRecord::Errors object for the supplied model object
  def build_errors(model, *fields)
    errors = ActiveRecord::Errors.new(model)
    fields.each do |field|
      errors.add(field)
    end
    # Adding an additional error on base
    errors.add_to_base(ActiveRecord::Errors.default_error_messages[:invalid]) unless fields.empty?
    errors
  end
end
