# Los edificios son fijos en cada planeta.
class Edificio # < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  PORCENTAJES_PRODUCCION = (0..100).step(10)

  include ActiveModel::Model
  include Nivelable

  attr_accessor :propietario, :nivel

  # belongs_to :planeta
  # belongs_to :luna

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  # scope :activo, -> { where "nivel >= 1" }
  # scope :mina, -> { where type: [MinaMetal, MinaCristal, MinaDeuterio] }

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def puede_expandirse?
    !esta_expandiendose? && propietario.puede_construir? && cumple_requisitos? && propietario.puede_pagar?(metal, cristal, deuterio, energia)
  end

  def cumple_requisitos?
    true
  end

  def duracion_expansion(edificable)
    if Rails.env.production?
      # esto deberá moverse al propietario porque por ejemplo en la luna no se pueden hacer nanos, por lo que depende de los edificios que pueda construir el propietario.
      (((metal.costo + cristal.costo).to_f / (2500 * (1 + edificable.fabrica_robots.nivel) * 2**edificable.try(:fabrica_nanobots).try(:nivel).to_i)).to_f * 3600).floor
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

  def tipo
    self.class.model_name.to_s.underscore
  end

  def to_s
    self.class.model_name.human
  end

  alias_method :to_label, :to_s

  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def before_completar_expansion
    propietario.actualizar_recursos!
  end

end
