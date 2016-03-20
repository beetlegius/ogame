class Nave

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  include ActiveModel::Model
  include Costeable

  attr_accessor :propietario, :cantidad, :estructura, :escudo, :poder, :velocidad, :carga, :consumo

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  class << self

    attr_accessor :fuego_rapido

    def establecer_fuego_rapido(*args)
      atributos = args.extract_options!
      @fuego_rapido = atributos || {}
    end

  end

  def initialize(attributes)
    super(attributes)
    configurar
  end

  def duracion_expansion(planeta)
    3
  end

  def costo_exponencial?
    false
  end

  def establecer_caracteristicas(*args)
    atributos = args.extract_options!
    @estructura = atributos[:estructura] || 0
    @escudo     = atributos[:escudo]     || 0
    @poder      = atributos[:poder]      || 0
    @velocidad  = atributos[:velocidad]  || 0
    @carga      = atributos[:carga]      || 0
    @consumo    = atributos[:consumo]    || 0
  end

  def cumple_requisitos?
    true
  end

  def to_partial_path
    "naves/nave"
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

  def configurar
  end

end
