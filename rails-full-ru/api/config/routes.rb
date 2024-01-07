# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'
    resources :users
  end

  namespace :api  do
    resources :users, only: %i[index show]
  end
end
