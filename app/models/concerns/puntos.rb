module Puntos
  extend ActiveSupport::Concern

  def puntos
    puntos_edificios + puntos_naves + puntos_defensas
  end

  private

  def puntos_edificios
    edificios.to_a.sum &:puntos
  end

  def puntos_naves
    0
  end

  def puntos_defensas
    0
  end

end
