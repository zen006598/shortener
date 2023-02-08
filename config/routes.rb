Rails.application.routes.draw do
  root 'urls#new'
  resources :urls, only: %w[new show create]
  get '/:slug', to: 'urls#redirect'
end
