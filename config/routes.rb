Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users do
    resources :stopwatches
  end

  resources :clock
  resources :alarms
  root to: 'clock#main'
  get 'all_timezones',      to: 'clock#timezones'
  get 'stopwatch',          to: 'clock#stopwatch'
  get 'favorites_timezones', to: 'clock#favorites'
end
