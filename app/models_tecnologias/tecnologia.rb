# Las cuentas investigan tecnologías, las cuales sirven para mejorar diversas cuestiones.
class Tecnologia < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  include Nivelable

  belongs_to :cuenta

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validates :cuenta, presence: true

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  class << self

    attr_accessor :nivel_laboratorio_requerido

    def requiere_laboratorio(nivel = 1)
      @nivel_laboratorio_requerido ||= nivel
    end

    def nivel_laboratorio_requerido
      @nivel_laboratorio_requerido ||= 1
    end

  end

  def puede_expandirse?
    !esta_expandiendose? && cumple_requisitos?
  end

  def cumple_requisitos?
    true
  end

  def duracion_expansion(planeta)
    if Rails.env.production?
      (3600 * (metal.costo + cristal.costo).to_f / 1000 * (1 + planeta.nivel_laboratorio)).floor
    else
      3
    end
  end

  def to_partial_path
    "tecnologias/tecnologia"
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

end
