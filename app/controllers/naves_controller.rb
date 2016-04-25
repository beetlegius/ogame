# Naves Controller
class NavesController < ApplicationController

  def hangar
    @titulo = 'Hangar'
    @naves = current_planeta.naves_ataque.disponible
    @naves_construyendo = current_planeta.naves_ataque.fabricando
    @procesos = current_planeta.naves_ataque.procesos
    render :index
  end

  def defensa
    @titulo = 'Defensa'
    @naves = current_planeta.naves_defensa.disponible
    @naves_construyendo = current_planeta.naves_defensa.fabricando
    @procesos = current_planeta.naves_defensa.procesos
    render :index
  end

  def fabricar
    for nave, cantidad in params[:nave]
      @nave = current_planeta.send nave
      @nave.fabricar! cantidad
    end
    redirect_to :back, notice: notice
  end

end
