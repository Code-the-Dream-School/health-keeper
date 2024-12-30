# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pdfs/index'
  get 'pdfs/show'
  get 'pdfs/download'
  resources :posts
  get 'users/index'
  get 'users/show'
  resources :biomarkers do
    resources :reference_ranges, only: %i[show new create edit update destroy]
  end
  resources :reference_ranges

  resources :measurements
  resources :lab_tests
  resources :health_records do
    resource :edit, controller: 'health_record_edits', only: [:show, :update]
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'

  resources :pdfs do
    member do
      get :download
      get :view
    end
  end

  get 'shared/pdf_dropdown_item', to: 'application#pdf_dropdown_item'
end
