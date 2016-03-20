# Defensas Controller
class DefensasController < ApplicationController

  def index
    @defensas = current_planeta.defensas_disponibles
  end

end
