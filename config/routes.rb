ActionController::Routing::Routes.draw do |map|

  map.resources :units
  map.resources :periods
  
  map.resources :ingredient_categories do |ingredient_category|
    ingredient_category.resources :ingredients
  end
  
  map.resources :recipe_categories do |recipe_category|
    recipe_category.resources :recipes do |recipe|
      recipe.resources :measures
    end
  end
  
  # Home page
  map.root :controller => 'recipe_categories'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
