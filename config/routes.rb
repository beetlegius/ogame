Rails.application.routes.draw do

	concern :fabricable do
		post :fabricar, on: :collection
	end

	concern :expandible do
		patch ':tipo/expandir', action: :expandir, on: :collection, as: :expandir
  	patch ':tipo/cancelar', action: :cancelar, on: :collection, as: :cancelar
	end

	# resources :galaxias, only: :index # galaxia
	get 'galaxias/:numero_galaxia::numero_sistema', to: 'galaxias#index', as: :galaxias
	post 'galaxias/navegar', to: 'galaxias#navegar', as: :navegar

	# resources :defensas, only: :index, concerns: :fabricable # defensas
	resources :naves, only: [], concerns: :fabricable # naves
	get :hangar, to: 'naves#hangar'
	get :defensa, to: 'naves#defensa'

	resources :tecnologias, only: :index, concerns: :expandible # investigación
  resources :edificios, only: :index, concerns: :expandible # edificios

  resources :cuentas, only: :show # visión general

  resources :planetas, only: :update do
    post :seleccionar, on: :collection
  end

  get :recursos, to: 'planetas#recursos', as: :recursos

  root to: 'cuentas#show', id: 1

end
