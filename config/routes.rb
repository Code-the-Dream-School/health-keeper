# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  resources :pdfs do
    collection do
      delete :delete_selected
    end
  end
  
  resources :health_records
  resources :lab_tests
  resources :measurements, only: [:index, :show]
  resources :biomarkers
  resources :reference_ranges
  
  root 'pdfs#new'
end
