Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_in/:scope', to: 'devise/sessions#new', as: :new_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_session
  end

  authenticated :user do
    root to: 'high_voltage/pages#show', id: 'dash/home', as: :authenticated_root
  end

  root to: 'high_voltage/pages#show', id: 'home'
end
