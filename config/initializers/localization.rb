# Setting up localization related configuration

# ActiveRecord errors localization
ActiveRecord::Errors.default_error_messages = {
  :inclusion => "activerecord_error_inclusion",
  :exclusion => "activerecord_error_exclusion",
  :invalid => "activerecord_error_invalid",
  :confirmation => "activerecord_error_confirmation",
  :accepted  => "activerecord_error_accepted",
  :empty => "activerecord_error_empty",
  :blank => "activerecord_error_blank",
  :too_long => "activerecord_error_too_long",
  :too_short => "activerecord_error_too_short",
  :wrong_length => "activerecord_error_wrong_length",
  :taken => "activerecord_error_taken",
  :not_a_number => "activerecord_error_not_a_number"
}

# GLoc configuration
GLoc.set_config :default_language => :en
GLoc.clear_strings
GLoc.set_kcode
GLoc.load_localized_strings

## WillPaginate localization ##

# Custom LinkRenderer for localization
# It includes GLoc and overrides the to_html method to add GLoc helpers
class LocalizedLinkRenderder < WillPaginate::LinkRenderer
  include GLoc
  
  def to_html
    links = @options[:page_links] ? windowed_links : []
    # previous/next buttons
    links.unshift page_link_or_span(@collection.previous_page, 'disabled prev_page', l(@options[:prev_label]))
    links.push    page_link_or_span(@collection.next_page,     'disabled next_page', l(@options[:next_label]))
    
    html = links.join(@options[:separator])
    @options[:container] ? @template.content_tag(:div, html, html_attributes) : html
  end
end

# Changing default options
WillPaginate::ViewHelpers.pagination_options[:prev_label] = :label_link_page_previous
WillPaginate::ViewHelpers.pagination_options[:next_label] = :label_link_page_next
WillPaginate::ViewHelpers.pagination_options[:renderer] = LocalizedLinkRenderder
