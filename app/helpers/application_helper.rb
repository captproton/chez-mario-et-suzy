# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Returns text for Textile formatting information
  def textile_info
    content_tag(:p, l(:label_info_textile, link_to("Textile", "http://hobix.com/textile/quick.html", :popup => true)), :class => 'textile_info')
  end
  
  # Returns the localized month name corresponding to the month symbol supplied
  def month_name(month_symbol)
    return "" unless Period.month_symbols.include?(month_symbol)
    l(("label_month_" + month_symbol.to_s).to_sym)
  end
  
  # Build a labelled form for the specified object
  def labelled_form_for(object, options = {}, &proc)
    options[:html] ||= {}
    options[:html][:class] = 'labelledform' unless options[:html].has_key?(:class)
    form_for(object, options.merge({ :builder => LabelledFormBuilder, :lang => current_language}), &proc)
  end
  
  # Returns { :class => 'active' } if the current page is in the section. Returns {} otherwise
  def tab_class_for_section(section)
    html_options = {}
    case section
    when :ingredients
      html_options[:class] = 'active' if %w{ingredient_categories ingredients periods units}.include?(controller.controller_name)
    when :recipes
      html_options[:class] = 'active' if %w{recipe_categories recipes measures}.include?(controller.controller_name)
    end
    html_options
  end
  
  # Overwriting for localized error messages on model objects
  def error_messages_for(object_name, options = {})
    options = options.symbolize_keys
    object = instance_variable_get("@#{object_name}")
    if object && !object.errors.empty?
      # build full_messages here with controller current language
      full_messages = []
      object.errors.each do |attr, msg|
        next if msg.nil?
        msg = msg.first if msg.is_a? Array
        if attr == "base"
          full_messages << l(msg)
        else
          full_messages << "&#171; " + (l_has_string?("field_" + attr) ? l("field_" + attr) : object.class.human_attribute_name(attr)) + " &#187; " + l(msg) unless attr == "custom_values"
        end
      end 
      content_tag("div",
        content_tag(
          options[:header_tag] || "span", lwr(:gui_validation_error, full_messages.length) + ":"
        ) +
        content_tag("ul", full_messages.collect { |msg| content_tag("li", msg) }),
        "id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation"
      )
    else
      ""
    end
  end
end
