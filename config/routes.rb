Rails.application.routes.draw do
  resources :urls, only: %i[create show] do
    member do
      get :show_stats
    end
  end
end
