# frozen_string_literal: true

Rails.application.routes.draw do
  resources :biomarkers do
    resources :reference_ranges, only: %i[show new create edit update destroy]
    get 'reference_ranges', on: :member
  end
  resources :reference_ranges

  resources :measurements
  resources :lab_tests do
    collection do
      get :new_blood_test
      post :create_blood_test
    end
  end
  resources :health_records
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'
end
