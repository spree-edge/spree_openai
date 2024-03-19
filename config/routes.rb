Spree::Core::Engine.add_routes do
  namespace :admin do
    resource :open_ai, only: [:edit, :update]

    resources :products do
      post 'generate_description', on: :member
    end

    post '/translate', to: 'translations#translate'
  end
end
