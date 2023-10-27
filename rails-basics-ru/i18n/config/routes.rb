# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  # http://example.com/en/posts
  root to: "home#index"
  scope (':locale'), locale: /ru|en/ do

    resources :posts do
      scope module: :posts do
        resources :comments
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
