Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1, defaults: {format: 'json'} do
        resources :athletes
        resources :stats
        resources :competitions do
            post :stats
            post :finish_competition
        end
    end
  end
end
