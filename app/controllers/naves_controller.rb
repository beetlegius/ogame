# Naves Controller
class NavesController < ApplicationController

  def index
    @naves = current_planeta.naves_disponibles
    @naves_construyendo = current_planeta.naves_en_fabricacion
    @procesos = current_planeta.procesos_de_naves
  end

  def fabricar
    for nave, cantidad in params[:nave]
      @nave = current_planeta.send nave
      @nave.fabricar! cantidad
    end
  	redirect_to naves_path, notice: notice
  end

end
