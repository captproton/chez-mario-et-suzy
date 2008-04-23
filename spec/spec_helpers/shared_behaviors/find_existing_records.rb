describe "find existing records", :shared => true do
  before(:each) do
    model_class.delete_all
    @model_1 = create_model
    @model_2 = create_model
  end
  
  it "should have a non-empty collection of records" do
    model_class.find(:all).should_not be_empty
  end
  
  it "should have a correct number of records" do
    model_class.should have(2).records
  end
  
  it "should find an existing record" do
    found_model = model_class.find(@model_1.id)
    found_model.should eql(@model_1)
  end
end
