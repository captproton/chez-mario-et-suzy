class Ingredient < ActiveRecord::Base
  belongs_to :ingredient_category
  belongs_to :unit
  belongs_to :period
  
  validates_presence_of :name, :ingredient_category, :period, :unit
  
  before_validation :fill_default_values
  
  private
    def fill_default_values
      self.period = Period.whole_year unless self.period
      self.unit = Unit.none unless self.unit
    end
end
