# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  ActiveAdmin.routes(self)
  devise_for :user, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  constraints subdomain: 'give' do
    scope module: :give do
      root to: 'projects#index', as: :give_root
      get '/projects', to: redirect('/')
      resources :projects, only: [:show]
      authenticated :user do
        resource :donor, path: 'me', only: %i[edit update]
        resources :pledges, path: 'donations', only: [:index]
      end
      resources :donees, only: [:show], path: '' do
        collection do
          get :find
        end
        member do
          get 'about'
        end
        scope module: :donees do
          resources :subscriptions
          resources :pledges, path: 'giving', except: [:destroy] do
            member do
              get 'success'
              get 'failure'
            end
          end
        end
      end
    end
  end

  constraints subdomain: 'mpd' do
    scope module: :mpd do
      authenticated :user do
        root to: 'pages#show', id: 'dash/home', as: :authenticated_root
        resource :donee, path: 'me', only: %i[edit update]
        resources :donations, only: [:index]
        resources :deposits
        resources :donors, only: [:index]
      end
      get '*path', to: redirect('/')
      root to: 'pages#show', id: 'home'
    end
  end
end
