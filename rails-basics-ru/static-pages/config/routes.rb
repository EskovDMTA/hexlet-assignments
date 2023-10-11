# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  root "home#index"
  get "pages/about", to: "pages#about"
  resources :pages, only: [:show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
