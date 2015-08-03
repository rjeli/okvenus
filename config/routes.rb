Rails.application.routes.draw do
  resources :questions
  devise_for :users
  root 'home#index'

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/answer', to: 'dashboard#show_answer', as: 'answers'
  post '/answer', to: 'dashboard#commit_answer'
  get '/myanswers', to: 'dashboard#my_answers', as: 'my_answers'
end
