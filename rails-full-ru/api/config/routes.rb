# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'
  end

  namespace :api, as: '' do
    resources :users, only: %i[index show]
  end
end
