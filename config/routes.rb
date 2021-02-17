Rails.application.routes.draw do
  get 'stopwatches/index'
  get 'alarms/index'
  get 'alarm/index'
  get 'stopwatch/index'
  devise_for :users

  resources :users do
    resources :clock, except: [:index]
    resources :stopwatches
    resources :alarms
  end

  root to: 'clock#index'
  get 'all_timezones',      to: 'clock#timezones'
  get 'stopwatch',          to: 'clock#stopwatch'
  get 'favorite_timezones', to: 'timezones#index'
end
