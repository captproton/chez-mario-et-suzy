module ViewSpecHelper
  def errors_mock_for(model)
    errors = mock("errors", :null_object => true)
    errors.stub!(:empty?).and_return(true)
    model.stub!(:errors).and_return(errors)
    errors
  end
  
  def delete_link_pattern
    /.*#{Regexp.escape("m.setAttribute('name', '_method'); m.setAttribute('value', 'delete')")}.*/
  end
  
  # Write response body to output file.
  # This can be very helpful when debugging specs that test HTML.
  def output_body(response)
    File.open("tmp/index.html", "w") { |f| f.write(response.body) }
  end
end
