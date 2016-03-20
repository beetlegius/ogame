# Las cuentas investigan tecnologías, las cuales sirven para mejorar diversas cuestiones.
class Tecnologia

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  include ActiveModel::Model
  include Nivelable

  attr_accessor :propietario, :nivel

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validates :propietario, presence: true

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

  def tipo
    self.class.model_name.to_s.underscore
  end

  def puede_expandirse?
    !esta_expandiendose? && cumple_requisitos? # hay que agregar que no se esté expandiendo el laboratorio en ningún planeta!
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
