# Tecnologías Controller
class TecnologiasController < ApplicationController
  before_action :set_tecnologia, only: %w(expandir cancelar)
  # load_and_authorize_resource through: :current_cuenta

  def index
    @tecnologias = current_planeta.tecnologias_disponibles
  end

  def expandir
  	@tecnologia.expandir! current_planeta
  	redirect_to tecnologias_path, notice: notice
  end

  def cancelar
    @tecnologia.cancelar_expansion! current_planeta
    redirect_to tecnologias_path, notice: notice
  end

  private

  def set_tecnologia
    @tecnologia = current_planeta.cuenta.send(params[:tipo])
  end

end
