class Period < ActiveRecord::Base
  validates_presence_of :start_month, :end_month
  validates_numericality_of :start_month, :only_integer => true
  validates_numericality_of :end_month, :only_integer => true
  validates_inclusion_of :start_month, :in => 1..12
  validates_inclusion_of :end_month, :in => 1..12
  
  @@month_symbols = [
    :january, :february, :march, :april, :may, :june,
    :july, :august, :september, :october, :november, :december
  ]
  cattr_accessor :month_symbols
  
  def start_month_symbol
    @@month_symbols[start_month - 1]
  end
  
  def end_month_symbol
    @@month_symbols[end_month - 1]
  end
  
  def self.whole_year
    whole_year = find(:first, :conditions => "start_month = 1 AND end_month = 12")
    unless whole_year
      whole_year = Period.new(:start_month => 1, :end_month => 12)
      whole_year.save!
      whole_year.reload
    end
    whole_year
  end
end
