# Galaxias Controller
class GalaxiasController < ApplicationController

  def index
    @numero_galaxia = params[:numero_galaxia].presence || current_planeta.numero_galaxia
    @numero_sistema = params[:numero_sistema].presence || current_planeta.numero_sistema
    @planetas = current_universo.planetas.ubicacion(@numero_galaxia, @numero_sistema)
  end

  def navegar
    if params[:numero_galaxia].present? && params[:numero_sistema].present?
      # acá habría que consumirle 10 de deuterio al current_planeta
      redirect_to galaxias_path(numero_galaxia: params[:numero_galaxia], numero_sistema: params[:numero_sistema])
    else
      redirect_to :back
    end
  end

end
