describe "a page in the recipes section", :shared => true do
  it "should show the recipes tab as active" do
    call_render
    response.should have_tag("div#menu>ul>li>a.active[href=/recipe_categories]")
  end
  
  it "should not show the ingredients tab as active" do
    call_render
    response.should_not have_tag("div#menu>ul>li>a.active[href=/ingredient_categories]")
  end
end
