class Measure < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  
  validates_presence_of :number, :recipe, :ingredient
  validates_numericality_of :number
  
  before_validation :fill_default_values
  
  private
    def fill_default_values
      self.number = 1 unless self.number
    end
end
