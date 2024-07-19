

Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: {
    registrations: 'registrations'
  }


  resources :events do
    collection do
      get 'search'
    end
 
    resources :events
    resources :ticket_types, only: [:new, :create, :edit, :update, :destroy]
    resources :bookings, only: [:create, :destroy]
   end
 

  require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'


  get 'booking_history', to: 'bookings#history', as: 'booking_history'
  delete 'booking_history/:id', to: 'bookings#cancel', as: 'cancel_booking'

  root 'home#index'
end
