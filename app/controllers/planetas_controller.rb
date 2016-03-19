# Planetas Controller
class PlanetasController < ApplicationController
  load_and_authorize_resource through: :current_cuenta

  def update
    @planeta.update! planeta_params
    redirect_to :back
  end

  def seleccionar
    session[:current_planeta_id] = @planeta.id
    redirect_to :back
  end

  def recursos
  end

  private

  def planeta_params
    params.require(:planeta).permit(:porcentaje_produccion_mina_metal, :porcentaje_produccion_mina_cristal, :porcentaje_produccion_mina_deuterio, :porcentaje_produccion_planta_energia, :porcentaje_produccion_planta_fusion)
  end

end
