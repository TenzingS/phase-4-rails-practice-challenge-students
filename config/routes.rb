Rails.application.routes.draw do
  resources :students, except: :show
  resources :instructors, except: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
