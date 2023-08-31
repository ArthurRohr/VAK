Rails.application.routes.draw do
  require "sidekiq/web"
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :recipes do
    resources :nutritional_values, only: :create
    resources :bookmarks, only: :create

  end

  resources :meal_plans, except: [:edit, :update] do
    resources :meal_plan_recipes, only: :create
  end

  resources :bookmarks, only: :destroy
  get '/ai_recipe', to: 'recipes#ai_recipe'


  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
