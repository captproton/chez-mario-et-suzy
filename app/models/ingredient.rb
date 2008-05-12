class Ingredient < ActiveRecord::Base
  belongs_to :ingredient_category
  belongs_to :unit
  belongs_to :period
  
  validates_presence_of :name, :ingredient_category
end
