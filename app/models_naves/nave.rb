class Nave

  # CONFIG

  include ActiveModel::Model
  include Costeable

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

  def esta_fabricandose?
    proceso.present?
  end

  def fabricar!(cantidad)
    cantidad = cantidad.to_i

    propietario.pagar! metal, cristal, deuterio, cantidad

    ultimo_proceso = propietario.naves_ataque.procesos.last
    if ultimo_proceso
      fabricante = ultimo_proceso.payload_object.fabricante
      fabricado = ultimo_proceso.payload_object.fabricado

      hora_finalizacion = ultimo_proceso.run_at + fabricado.duracion_expansion(fabricante) * ultimo_proceso.payload_object.cantidad_restante
    else
      hora_finalizacion = Time.now
    end

    fabricar_unidad! cantidad, hora_finalizacion
  end

  # Revisar cómo funciona cuando encolo varias naves.
  # Actualmente todas se construyen en simultáneo
  def fabricar_unidad!(cantidad_restante, hora_finalizacion)
    cantidad_restante = cantidad_restante.to_i
    return if cantidad_restante.zero?

    proceso = Delayed::Job.enqueue FabricarJob.new(propietario.id, propietario.class.name, tipo, cantidad_restante.pred), run_at: hora_finalizacion + duracion_expansion(propietario).seconds, queue: tipo
    propietario.procesos << proceso
  end

  def completar_fabricacion!(cantidad_restante)
    propietario.sumar_nave! self
    fabricar_unidad! cantidad_restante, Time.now
  end

  def duracion_expansion(planeta)
    if Rails.env.production?
      ( (metal.costo + cristal.costo).to_f / 5000 * (2 / (planeta.try(:hangar).try(:nivel).to_f + 1).to_f) * (0.5 ** planeta.try(:fabrica_nanobots).try(:nivel).to_f) * 3600 ).to_f.floor
    else
      10
    end
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

  def cumple_requisitos?
    true
  end

  def metodo_cantidad
    "cantidad_#{tipo}".to_sym
  end

  def to_partial_path
    "naves/nave"
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
