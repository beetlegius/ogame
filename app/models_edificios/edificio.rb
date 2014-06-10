# Los edificios son fijos en cada planeta.
class Edificio < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  PORCENTAJES_PRODUCCION = (0..100).step(10)

  include Nivelable

  belongs_to :planeta
  belongs_to :luna

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  scope :activo, -> { where "nivel >= 1" }
  scope :mina, -> { where type: [MinaMetal, MinaCristal, MinaDeuterio] }

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def puede_expandirse?
    !esta_expandiendose? && planeta.puede_construir? && cumple_requisitos? && planeta.puede_pagar?(metal, cristal, deuterio, energia)
  end

  def cumple_requisitos?
    true
  end

  def duracion_expansion(planeta)
    if Rails.env.production?
      (((metal.costo + cristal.costo).to_f / (2500 * (1 + planeta.fabrica_robots.nivel) * 2**planeta.fabrica_nanobots.nivel)).to_f * 3600).floor
    else
      3
    end
  end

  def to_partial_path
    "edificios/edificio"
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################

  def to_s
    self.class.model_name.human
  end

  alias_method :to_label, :to_s

  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def before_completar_expansion
    planeta.actualizar_recursos!
  end

end
