Rails.application.routes.draw do

	resources :tecnologias, only: :index do # investigación
  	put :expandir, on: :member
  	put :cancelar, on: :member
  end

  resources :edificios, only: :index do # edificios
  	get :expandir, on: :collection
  	put :cancelar, on: :member
  end

  resources :cuentas, only: :show # visión general

  resources :planetas, only: :update do
    post :seleccionar, on: :collection
  end

  get :recursos, to: 'planetas#recursos', as: :recursos

  root to: 'cuentas#show', id: 1

end
