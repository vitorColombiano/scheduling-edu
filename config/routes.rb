Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post "auth/login", to: "auth#login"
      post "auth/register", to: "auth#register"
      delete "auth/logout", to: "auth#logout"

      resources :users, param: :uuid, only: [ :index, :show, :create, :update, :destroy ]
      resources :students, only: [ :index, :show, :create, :update, :destroy ] do
        resources :schedulings, only: [ :index ], controller: "students/schedulings"
      end
      resources :professors, only: [ :index, :show, :create, :update, :destroy ] do
        resources :schedulings, only: [ :index ], controller: "professors/schedulings"
        resources :course_classes, only: [ :index ], controller: "professors/course_classes"
      end
      resources :schedulings, only: [ :index, :show, :create, :update, :destroy ]
      resources :course_classes, only: [ :index, :show, :create, :update, :destroy ]
      resources :products, only: [ :index, :show, :create, :update, :destroy ]
    end
  end

  root "rails/health#show"
end
