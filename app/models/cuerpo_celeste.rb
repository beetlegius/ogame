class CuerpoCeleste < ActiveRecord::Base

  # CONFIG

  # CALLBACKS

  after_initialize :inicializar
  after_create :configurar

  # RELATIONS

  belongs_to :cuenta
  belongs_to :universo, required: true

  has_many :procesos, class_name: '::Delayed::Job', as: :propietario

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  ### NAVES

  def cantidad_maxima_fabricacion(fabricable)
    cantidad_maxima_metal = recurso_metal / fabricable.metal.costo if fabricable.metal.costo > 0
    cantidad_maxima_cristal = recurso_cristal / fabricable.cristal.costo if fabricable.cristal.costo > 0
    cantidad_maxima_deuterio = recurso_deuterio / fabricable.deuterio.costo if fabricable.deuterio.costo > 0
    [cantidad_maxima_metal, cantidad_maxima_cristal, cantidad_maxima_deuterio].compact.min
  end

  def puede_fabricar?(fabricable)
    !hangar.esta_expandiendose? && !fabrica_nanobots.esta_expandiendose? && cantidad_maxima_fabricacion(fabricable) > 0
  end

  def sumar_nave!(nave)
    increment! nave.metodo_cantidad
  end

  ### EDIFICIOS

  def puede_construir?
    cuenta.present? && campos_disponibles? && puede_construir_en_simultaneo?
  end

  def puede_construir_en_simultaneo?
    edificios.select(&:esta_expandiendose?).count < universo.cantidad_construcciones_en_simultaneo
  end

  def subir_nivel!(edificio)
    increment! edificio.metodo_nivel
  end

  # ALIASES

  def to_s
    coordenadas_completas
  end

  # PRIVATE METHODS

  private

  def inicializar
    self.ultima_actualizacion_recursos ||= Time.now
  end
end
