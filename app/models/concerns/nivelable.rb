module Nivelable
  extend ActiveSupport::Concern

  included do
    validates :nivel, presence: true
  end

  module ClassMethods

    attr_accessor :costo_metal_base, :costo_cristal_base, :costo_deuterio_base, :costo_energia_base

    def establecer_costos(*args)
      atributos = args.extract_options!
      @costo_metal_base = atributos[:metal] || 0
      @costo_cristal_base = atributos[:cristal] || 0
      @costo_deuterio_base = atributos[:deuterio] || 0
      @costo_energia_base = atributos[:energia] || 0
    end

    def factor(numero = 2)
      @factor ||= numero
    end

  end

  def puede_costearse?(planeta)
    planeta.puede_pagar? metal, cristal, deuterio, energia
  end

  def esta_expandiendose?
    proceso_id && fecha_actualizacion.present?
  end

  def puede_cancelar_expansion?
    esta_expandiendose? && tiempo_restante.to_i > 5
  end

  def tiempo_restante
    ahora = Time.now
    (fecha_actualizacion - ahora).round if fecha_actualizacion && fecha_actualizacion > ahora
  end

  def puntos
    return 0 if nivel.zero?

    (1..nivel).inject(0) { |suma, index| suma + metal.costo(index) + cristal.costo(index) + deuterio.costo(index) }
  end

  def proximo_nivel
    nivel.next
  end

  def metal
    Metal.new propietario: self
  end

  def cristal
    Cristal.new propietario: self
  end

  def deuterio
    Deuterio.new propietario: self
  end

  def energia
    Energia.new propietario: self
  end

  def expandir!(planeta)
    raise Excepciones::Nivelable::FalloExpansion.new(self) unless planeta.puede_expandir?(self)

    planeta.pagar! metal, cristal, deuterio
    tiempo = duracion_expansion(planeta)
    proceso = delay(run_at: tiempo.seconds.from_now).completar_expansion!

    update! fecha_actualizacion: Time.now + tiempo, proceso_id: proceso.id
  end

  def cancelar_expansion!(planeta)
    raise Excepciones::Nivelable::FalloCancelacion.new(self) unless puede_cancelar_expansion?

    planeta.devolver! metal, cristal, deuterio
    proceso.try :destroy

    update! fecha_actualizacion: nil, proceso_id: nil
  end

  def completar_expansion!
    before_completar_expansion
    update! nivel: nivel.next, fecha_actualizacion: nil, proceso_id: nil
    after_completar_expansion
  end

  private

  def proceso
    Delayed::Job.find(proceso_id) if proceso_id
  end

  def before_completar_expansion
  end

  def after_completar_expansion
  end

end
