ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
  
  # Admin Routes
  
  map.namespace :admin do |admin|
    admin.root :controller => 'feeds'
    admin.resources :feeds, :collection => { :cache => :get }, :has_many => :items
  end
  
  map.resources :feeds, :items
  map.root :controller => 'items'
  
  map.with_options :controller => 'pages' do |page|
    page.start '3', :action => 'start'
    page.page_1 'loves', :action => 'page_1'
    page.page_2 'loves/carrie-anne', :action => 'page_2'
    page.page_3 'loves/carrie-anne/aldridge', :action => 'page_3'
    page.page_4 'loves/carrie-anne/aldridge/with-all', :action => 'page_4'
    page.page_5 'loves/carrie-anne/aldridge/with-all/his-heart', :action => 'page_5'
    page.page_6 '3/years-together-today', :action => 'page_6'
    page.page_7 '3/rd-december', :action => 'page_7'
  end
  
  map.connect 'javascripts/items/:id.js', :controller => 'items', :format => 'js'
  map.connect ':colour_scheme', :controller => 'items', :colour_scheme => /(black|bleached|rich|vintage|white)/
  
end
