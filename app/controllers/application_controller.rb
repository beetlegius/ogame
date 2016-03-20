# Application Controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_universo, :current_cuenta, :current_planeta

  rescue_from Excepciones::Nivelable::FalloExpansion, with: :mensaje_excepcion
  rescue_from Excepciones::Nivelable::FalloCancelacion, with: :mensaje_excepcion

  def current_user
  end

  def current_planeta
    session[:current_planeta_id] ||= current_cuenta.planeta_principal.id
  	@current_planeta ||= current_cuenta.planetas.find session[:current_planeta_id]
  rescue ActiveRecord::RecordNotFound => excepciont
    session[:current_planeta_id] = nil
    current_planeta
  end

  def current_cuenta
    session[:current_cuenta_id] ||= 1
    @current_cuenta ||= Cuenta.find session[:current_cuenta_id]
  end

  def current_universo
    @current_universo ||= Universo.first
  end

  private

  def mensaje_excepcion(excepcion)
    redirect_to :back, alert: excepcion.message
  end

end
