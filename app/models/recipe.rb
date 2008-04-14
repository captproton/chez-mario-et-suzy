class Recipe < ActiveRecord::Base
  belongs_to :recipe_category
  has_many :measures
  has_many :ingredients, :through => :measures
  
  validates_presence_of :name, :description, :directions, :recipe_category
end
