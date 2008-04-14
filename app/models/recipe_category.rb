class RecipeCategory < ActiveRecord::Base
  has_many :recipes
  
  validates_presence_of :name
end
