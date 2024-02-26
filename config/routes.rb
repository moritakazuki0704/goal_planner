Rails.application.routes.draw do
  devise_for :users,skip:[:passwords]
  root to: 'homes#top'
  get 'welcome' => 'homes#welcome', as: 'welcome'

  resource :user,only: [:destroy] do
    collection do
      get 'keyword_new'
      get 'keyword_confirm'
      patch 'keyword_update'
      get 'mission_statement_new'
      get 'mission_statement_confirm'
      patch 'mission_statement_update'
      get 'withdrawal'
    end
  end
  resources :ideals,except: [:new,:edit,:update] do
    collection do
      get 'personality_new'
      get 'appearance_new'
      get 'lifestyle_new'
      get 'spend_time_new'
      get 'working_new'
      get 'residence_new'
      get 'relationship_new'
      get 'partner_new'
      get 'role_model_new'
    end
  end
  resources :problems,except: [:edit,:destroy] do
    collection do
      get 'confirm'
    end
    resources :missions,only: [:create,:destroy] do
      member do
        post 'upload'
      end
      collection do
        post 'bulk_upload'
        delete 'bulk_destroy'
      end
    end
  end
  resources :schedules do
    resources :plans,only: [:create,:destroy] do
      member do
        patch 'upload'
      end
      collection do
        patch 'all_update'
        patch 'bulk_upload'
        delete 'bulk_destroy'
      end
    end
  end
  resources :motivations,except: [:new,:edit,:update] do
    collection do
      get 'positive_new'
      get 'negative_new'
      get 'to_do_new'
      get 'want_new'
    end
  end
  resources :scrap_books,except: [:new,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
