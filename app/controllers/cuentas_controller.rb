# Cuentas Controller
class CuentasController < ApplicationController
  load_and_authorize_resource through: :current_universo

  def show
    session[:current_cuenta_id] = @cuenta.id # debería ser según el usuario logueado
  end

end
