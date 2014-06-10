# Tecnologías Controller
class TecnologiasController < ApplicationController
  load_and_authorize_resource through: :current_cuenta

  def index
    @tecnologias = current_planeta.tecnologias_disponibles
  end

  def expandir
  	@tecnologia = current_planeta.tecnologias_disponibles.detect { |tecnologia| tecnologia.id == params[:id].to_i }
  	@tecnologia.expandir! current_planeta
  	redirect_to tecnologias_path, notice: notice
  end

  def cancelar
    @tecnologia.cancelar_expansion! current_planeta
    redirect_to tecnologias_path, notice: notice
  end

end
