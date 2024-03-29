# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN

  # END

  scope module: :web do
    root 'home#index'
  end

  mount RailsStats::Engine => '/stats'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
