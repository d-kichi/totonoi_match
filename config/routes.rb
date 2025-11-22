Rails.application.routes.draw do
  # ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # 既存のルーティングの下に追加
  resources :results, only: [:show]

  # 診断系
  resources :diagnoses, only: [:new, :create] do
    member do
      get 'question/:step', to: 'diagnoses#question', as: :question
      post 'answer', to: 'diagnoses#answer'
    end
    collection do
      get 'result', to: 'diagnoses#result'
    end
  end

  # 健康チェック
  get "up" => "rails/health#show", as: :rails_health_check

  # お問い合わせフォーム
  resources :contacts, only: [:new, :create] do
    get :thanks, on: :collection
  end

  # トップページ
  root "homes#index"

  # 診断データをリセットしてトップページに戻る
get 'reset_diagnosis', to: 'diagnoses#reset', as: :reset_diagnosis

get 'terms', to: 'pages#terms'
get 'privacy', to: 'pages#privacy'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
