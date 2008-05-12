class IngredientCategory < ActiveRecord::Base
  has_many :ingredients
  
  validates_presence_of :name
  
  # Impossible to destroy non-empty category
  before_destroy { |record| record.ingredients.empty? }
end
