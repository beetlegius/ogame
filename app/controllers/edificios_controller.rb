# Edificios Controller
class EdificiosController < ApplicationController
  load_and_authorize_resource through: :current_planeta

  def index
    @edificios = @edificios.select(&:cumple_requisitos?)
  end

  def expandir
  	@edificio.expandir! current_planeta
  	redirect_to edificios_path, notice: notice
  end

  def cancelar
    @edificio.cancelar_expansion! current_planeta
    redirect_to edificios_path, notice: notice
  end

end
