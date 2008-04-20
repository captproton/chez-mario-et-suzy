# Don't surround errored fields with a div element
ActionView::Base.field_error_proc = Proc.new{ |html_tag, instance| "#{html_tag}" }