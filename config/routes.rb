Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  ActiveAdmin.routes(self)

  constraints subdomain: 'give' do
    scope module: :give do
      root to: 'projects#index', as: :give_root
      get '/projects', to: redirect('/')
      resources :projects, only: [:show]
      get '/:id', to: 'users#show', as: :give_user
    end
  end

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_in/:scope', to: 'devise/sessions#new', as: :new_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_session
  end

  authenticated :user do
    root to: 'high_voltage/pages#show', id: 'dash/home', as: :authenticated_root
    resource :user, only: [:edit, :update]
    resources :donations, only: [:index, :show]
  end

  root to: 'high_voltage/pages#show', id: 'home'
  get '*path', to: redirect('/')
end
