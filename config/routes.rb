ActivityServer::Application.routes.draw do
  root 'manager#login'
  post 'manager/judge_manager'=>'manager#judge_manager'
  get 'manager/manage_user'=>'manager#manage_user'
  get 'manager/logout'=>'manager#logout'
  get 'manager/login'=>'manager#login'
  get 'manager/add_user'=>'manager#add_user'
  get 'manager/quit'=>'manager#quit'
  post 'manager/whether_login'=>'manager#whether_login'
  delete 'manager/destroy'=>'manager#destroy'
  get 'manager/manager_modify_password'=>'manager#manager_modify_password'
  patch 'manager/judge_login'=>'manager#judge_login'
  get 'user/register'=>'user#register'
  post 'manager/information_complete'=>'manager#information_complete'
  get 'user/welcome'=>'user#welcome'
  get 'user/input_name'=>'user#input_name'
  post 'user/name_exist_or_not'=>'user#name_exist_or_not'
  get 'user/answer_question_of_password'=>'user#answer_question_of_password'
  post 'user/answer_right_or_not'=>'user#answer_right_or_not'
  get 'user/password_confirm'=>'user#password_confirm'
  post 'user/password_empty_or_not'=>'user#password_empty_or_not'
  post 'user/login'=>'user#login'
  post '/session/synchronous_data'=>'session#synchronous_data'
  get '/user/bid_list'=>'user#bid_list'
  get '/user/sign_up'=>'user#sign_up'
  get '/user/bid_detail'=>'user#bid_detail'
  get '/session/show'=>'session#show'
  get '/session/jump'=>'session#jump'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
