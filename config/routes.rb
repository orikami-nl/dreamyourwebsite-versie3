Dywsite2::Application.routes.draw do
  get "/terms_and_conditions", :to => "terms_and_conditions#index"

  get "/disclaimer", :to => "disclaimer#index"

  get "/contact", :to => "contact#index"
	get "/contact/completed", :to => "contact#completed"
	post "/contact", :to => "contact#create"
  get "/home", :to => "home#index"
	get "/blog", :to => "blog#index"
  get "/products", :to => "products#index"
	get "/products/mobile", :to => "products#mobile"
	get "/products/webdevelopment", :to => "products#webdevelopment"
	get "/products/concept_development", :to => "products#concept_development"
  get "/adminbuttons/show.js", :to => "adminbuttons#show"
  get "/admin/clear", :to => "admin/pages#clear"

  match 'mobile', :to => 'mobile#index'
  match 'full', :to => 'home#full'
  devise_for :admins
  devise_scope :admin do
		get "login", :to => "devise/sessions#new"
		get "logout", :to=> "devise/sessions#destroy"
  end

  authenticate(:admin) do 
    mount Split::Dashboard, :at => 'split'
  end

  resources :projects
	#scope '/admin' do
	resources :partners do
		resources :posts, :path => "blog" do
			resources :comments, :except => [:new]
		end
	end
	#end

	namespace 'admin' do
		resources :pages, :only => [:index, :edit, :update]
	end 

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
