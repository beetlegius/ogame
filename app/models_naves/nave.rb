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

  def initialize(attributes = {})
    super(attributes)
    configurar
  end

  def fabricar!(cantidad)
    cantidad = cantidad.to_i

    propietario.pagar! metal, cristal, deuterio, cantidad

    fabricar_unidad! cantidad
  end

  # Revisar cómo funciona cuando encolo varias naves.
  # Actualmente todas se construyen en simultáneo
  def fabricar_unidad!(cantidad_restante)
    cantidad_restante = cantidad_restante.to_i
    return if cantidad_restante.zero?

    proceso = Delayed::Job.enqueue FabricarJob.new(propietario.id, propietario.class.name, tipo, cantidad_restante.pred), run_at: duracion_expansion(propietario).seconds.from_now, queue: tipo
    propietario.procesos << proceso
  end

  def completar_fabricacion!(cantidad_restante)
    propietario.sumar_nave! self
    fabricar_unidad! cantidad_restante
  end

  def duracion_expansion(planeta)
    # if Rails.env.production?
      # ( (metal.costo + cristal.costo).to_f / 5000 * (2 / (planeta.try(:hangar).try(:nivel).to_f + 1).to_f) * (0.5 ** planeta.try(:fabrica_nanobots).try(:nivel).to_f) * 3600 ).to_f.floor
    # else
      100
    # end
  end

  def tiempo_restante
    ahora = Time.now
    fecha_actualizacion = proceso.try(:run_at)
    (fecha_actualizacion - ahora).round if fecha_actualizacion && fecha_actualizacion > ahora
  end

  def proceso
    procesos.first
  end

  def procesos
    propietario.procesos.select { |proceso| proceso.queue == tipo }
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

  def metodo_cantidad
    "cantidad_nave_#{tipo}".to_sym
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
