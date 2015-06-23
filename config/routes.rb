DayMan::Application.routes.draw do

  root to: 'home#homepage'

  devise_for :users, :controllers => { :registrations => "users/registrations" }

  resources :users, except: [:create, :update] do
    collection do
      post :import
      post :create_user
      post :update_user
      post :id_for_edit
    end
  end

  resources :schedules ,except: [:show, :index] do
    collection do
      get 'update_schedule'
    end
  end

  resources :subjects ,except: [:show]
  resources :branches
  resources :semesters

  post 'schedules/initialize_subjects', :to => 'schedules#initialize_subjects'
 
  get '/home', to: 'home#index'

  get '/admin', to: 'admin#index'

  get '/admin/subjects', to: 'subjects#index'

  get '/admin/schedules' , to: 'schedules#index'

  get '/admin/branches', to: 'branches#index'

  get '/admin/semesters', to: 'semesters#index'

  get '/admin/users', to: 'users#select_options'

  get '/import', to: 'users#import_users'

  get '/import_errors', to: 'users#errors'

  get '/get_user_id', to: 'users#get_user_id'

  #mount FullcalendarEngine::Engine => "/fullcalendar_engine"

  #get '/users/professor_show', to: 'users#professor_show'

  #get '/schedules/new', to: 'schedules#prior_new'

  #get '/users/get_schedules', to: 'schedules#get_schedules'  #NOT WORKING!!!

  #get '/studenthome', to: 'home#studenthome'

  #get '/professorhome', to: 'home#professorhome'

  #get '/users/schedules', to: 'schedules#get_schedules'  #NOT WORKING!!!

  #get '/users', to: 'users#index'

  #get '/', to: 'index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
