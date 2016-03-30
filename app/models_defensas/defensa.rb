class Defensa

  # CONFIG

  include ActiveModel::Model
  include Costeable

  attr_accessor :propietario, :cantidad, :estructura, :escudo, :poder

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  class << self

    attr_accessor :fuego_rapido

    def establecer_fuego_rapido(*args)
      atributos = args.extract_options!
      @fuego_rapido = atributos || {}
    end

  end

  # INSTANCE METHODS

  def initialize(attributes)
    super(attributes)
    configurar
  end

  def duracion_expansion(planeta)
    # if Rails.env.production?
    ( (metal.costo + cristal.costo).to_f / 5000 * (2 / (planeta.try(:hangar).try(:nivel).to_f + 1).to_f) * (0.5 ** planeta.try(:fabrica_nanobots).try(:nivel).to_f) * 3600 ).to_f.floor
    # else
    #   3
    # end
  end

  def costo_exponencial?
    false
  end

  def establecer_caracteristicas(*args)
    atributos = args.extract_options!
    @estructura = atributos[:estructura] || 0
    @escudo = atributos[:escudo] || 0
    @poder = atributos[:poder] || 0
  end

  def cumple_requisitos?
    true
  end

  def to_partial_path
    "defensas/defensa"
  end

  # ALIASES

  def tipo
    self.class.model_name.to_s.underscore
  end

  def to_s
    self.class.model_name.human
  end

  alias_method :to_label, :to_s

  # PRIVATE METHODS

  private
  
  def configurar
  end

end
