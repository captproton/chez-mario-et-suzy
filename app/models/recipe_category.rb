class RecipeCategory < ActiveRecord::Base
  has_many :recipes
  
  validates_presence_of :name
  
  # Impossible to destroy non-empty category
  before_destroy { |record| record.recipes.empty? }
end
