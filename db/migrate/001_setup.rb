class Setup < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :name
      t.string :abbreviation
      t.timestamps
    end
    
    create_table :ingredient_categories do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :periods do |t|
      t.integer :start_month
      t.integer :end_month
      t.timestamps
    end
    
    create_table :ingredients do |t|
      t.string :name
      t.integer :unit_id
      t.integer :ingredient_category_id
      t.integer :period_id
      t.timestamps
    end
    
    create_table :recipe_categories do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.text :directions
      t.integer :recipe_category_id
      t.timestamps
    end
    
    create_table :measures do |t|
      t.integer :number
      t.integer :recipe_id
      t.integer :ingredient_id
      t.timestamps
    end
  end

  def self.down
    drop_table :units
    drop_table :ingredient_categories
    drop_table :periods
    drop_table :ingredients
    drop_table :recipe_categories
    drop_table :recipes
    drop_table :measures
  end
end
