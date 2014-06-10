# Planetas Controller
class PlanetasController < ApplicationController
  load_and_authorize_resource through: :current_cuenta

  def update
    @planeta.update! planeta_params
    redirect_to :back, notice: "Todo piola!"
  end

  def seleccionar
    session[:current_planeta_id] = @planeta.id
    redirect_to :back
  end

  def recursos
  end

  private

  def planeta_params
    params.require(:planeta).permit(mina_metal_attributes: [:id, :porcentaje_produccion], mina_cristal_attributes: [:id, :porcentaje_produccion], mina_deuterio_attributes: [:id, :porcentaje_produccion], planta_energia_attributes: [:id, :porcentaje_produccion])
  end

end
