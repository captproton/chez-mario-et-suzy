describe "a page with a flash notice", :shared => true do
  it "should show the flash notice when it exists" do
    flash[:notice] = "usefulnotice"
    call_render
    response.should have_tag("div#notice") do
      with_tag("p", /usefulnotice/)
    end
  end
  
  it "should not show the flash notice when it does not exist" do
    flash[:notice] = nil
    call_render
    response.should_not have_tag("div#notice")
  end
end
