# frozen_string_literal: true

Rails.application.routes.draw do
  resources :biomarkers do
    resources :reference_ranges
    resources :reference_ranges
  end
  resources :reference_ranges, only: %i[show new create edit update destroy]
  resources :measurements, only: [:index, :show]
  resources :lab_tests
  resources :health_records

  namespace :admin do
    resources :users, only: %i[index show edit update destroy] do
      member do
        get :edit_roles
        post :update_roles
        get :edit_assigned_users
        post :update_assigned_users
        post :switch_user
      end
    end
  end

  devise_for :users
  
  resources :pdfs do
    collection do
      delete :delete_selected
    end
  end
  
  root 'pdfs#new'
end
