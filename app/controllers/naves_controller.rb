# Naves Controller
class NavesController < ApplicationController

  def index
    @naves = current_planeta.naves_disponibles
  end

end
