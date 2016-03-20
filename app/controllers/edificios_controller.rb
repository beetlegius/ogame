# Edificios Controller
class EdificiosController < ApplicationController
  before_action :set_edificio, only: %w(expandir cancelar)

  def index
    @edificios = current_planeta.edificios_disponibles
  end

  def expandir
  	@edificio.expandir! current_planeta
  	redirect_to edificios_path, notice: notice
  end

  def cancelar
    @edificio.cancelar_expansion! current_planeta
    redirect_to edificios_path, notice: notice
  end

  private

  def set_edificio
    @edificio = current_planeta.send(params[:tipo])
  end

end
