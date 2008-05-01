class Unit < ActiveRecord::Base
  validates_presence_of :name, :abbreviation
  
  def none?
    self == Unit.none
  end
  
  def self.none
    none = find(:first, :conditions => "name = 'N/A' AND abbreviation = 'N/A'")
    unless none
      none = Unit.new(:name => "N/A", :abbreviation => "N/A")
      none.save!
      none.reload
    end
    none
  end
end
