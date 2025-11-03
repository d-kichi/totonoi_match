Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :diagnoses, only: [:new, :create] do
    member do
      get 'question/:step', to: 'diagnoses#question', as: :question
      post 'answer', to: 'diagnoses#answer'
    end
    collection do
      get 'result', to: 'diagnoses#result'
    end
  end

  root "homes#index"
end
