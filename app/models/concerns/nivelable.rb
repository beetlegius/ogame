module Nivelable
  extend ActiveSupport::Concern

  included do
    include Costeable

    validates :nivel, presence: true
  end

  def costo_exponencial?
    true
  end

  def esta_expandiendose?
    proceso.present?
  end

  def puede_cancelar_expansion?
    esta_expandiendose? && tiempo_restante.to_i > 5
  end

  def tiempo_restante
    ahora = Time.now
    fecha_actualizacion = proceso.try(:run_at)
    (fecha_actualizacion - ahora).round if fecha_actualizacion && fecha_actualizacion > ahora
  end

  def puntos
    return 0 if nivel.zero?

    (1..nivel).inject(0) { |suma, index| suma + metal.costo(index) + cristal.costo(index) + deuterio.costo(index) }
  end

  def proximo_nivel
    nivel.next
  end

  def expandir!(expandible)
    raise Excepciones::Nivelable::FalloExpansion.new(self) unless expandible.puede_expandir?(self)

    expandible.pagar! metal, cristal, deuterio
    proceso = Delayed::Job.enqueue ExpandirJob.new(self), run_at: duracion_expansion(expandible).seconds.from_now, :queue => tipo
    propietario.procesos << proceso
  end

  def cancelar_expansion!(expandible)
    raise Excepciones::Nivelable::FalloCancelacion.new(self) unless puede_cancelar_expansion?

    expandible.devolver! metal, cristal, deuterio
    proceso.try :destroy
  end

  def completar_expansion!
    before_completar_expansion
    propietario.subir_nivel! self
    after_completar_expansion
  end

  def metodo_nivel
    "nivel_#{tipo}".to_sym
  end

  def proceso
    propietario.procesos.detect { |proceso| proceso.queue == tipo }
  end

  private

  def before_completar_expansion
  end

  def after_completar_expansion
  end

end
