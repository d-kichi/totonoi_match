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

  # トップページ
  root "homes#index"

  # 診断データをリセットしてトップページに戻る
get 'reset_diagnosis', to: 'diagnoses#reset', as: :reset_diagnosis

end
