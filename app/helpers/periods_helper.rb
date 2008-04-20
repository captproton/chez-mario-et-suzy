module PeriodsHelper
  # Returns month choices for the select helper
  def month_choices
    choices = Array.new
    Period.month_symbols.each_with_index do |month, index|
      choices << [l(("label_month_" + month.to_s).to_sym), index + 1]
    end
    choices
  end
end
