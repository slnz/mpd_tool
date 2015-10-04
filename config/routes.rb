Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  ActiveAdmin.routes(self)
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_in/:scope', to: 'devise/sessions#new', as: :new_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_session
  end

  constraints subdomain: 'give' do
    scope module: :give do
      root to: 'projects#index', as: :give_root
      get '/projects', to: redirect('/')
      resources :projects, only: [:show]
      resources :users, only: [:show], path: '' do
        scope module: :users do
          resource :pledges, only: [:create, :new] do
            collection do
              get 'about'
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
        resource :user, only: [:edit, :update]
        resources :donations, only: [:index, :show]
      end
      get '*path', to: redirect('/')
      root to: 'pages#show', id: 'home'
    end
  end
end
