Rails.application.routes.draw do

	resources :tecnologias, only: :index do # investigación
  	patch ':tipo/expandir', action: :expandir, on: :collection, as: :expandir
  	patch ':tipo/cancelar', action: :cancelar, on: :collection, as: :cancelar
  end

  resources :edificios, only: :index do # edificios
  	patch ':tipo/expandir', action: :expandir, on: :collection, as: :expandir
  	patch ':tipo/cancelar', action: :cancelar, on: :collection, as: :cancelar
  end

  resources :cuentas, only: :show # visión general

  resources :planetas, only: :update do
    post :seleccionar, on: :collection
  end

  get :recursos, to: 'planetas#recursos', as: :recursos

  root to: 'cuentas#show', id: 1

end
