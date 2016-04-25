# Class description
class Ronda

  # CONFIG

  include ActiveModel::Model

  attr_accessor :batalla, :numero, :absorbido

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def initialize(*args)
    super
    self.absorbido = {}
    self.absorbido[batalla.flota_atacante.object_id] = 0
    self.absorbido[batalla.flota_defensora.object_id] = 0
  end

  def ejecutar
    puts "COMIENZA RONDA ##{@numero}"

    cargar_escudos

    for unidad in batalla.flota_atacante.unidades
      disparar(unidad, batalla.flota_defensora.unidades)
    end

    for unidad in batalla.flota_defensora.unidades
      disparar(unidad, batalla.flota_atacante.unidades)
    end

    eliminar_explotadas
    puts "DAÑO ABSORBIDO POR EL ATACANTE #{absorbido[batalla.flota_atacante.object_id]}"
    puts "DAÑO ABSORBIDO POR EL DEFENSOR #{absorbido[batalla.flota_defensora.object_id]}"
  end

  # ALIASES

  # PRIVATE METHODS

  private

  def cargar_escudos
    batalla.flota_atacante.unidades.each(&:restablecer_escudo)
    batalla.flota_defensora.unidades.each(&:restablecer_escudo)
  end

  def disparar(atacante, defensores)
    defensor = defensores.sample
    atacante.atacar(defensor, self) if !defensor.exploto?

    disparar(atacante, defensores) if atacante.debe_disparar_nuevamente?(defensor)
  end

  def eliminar_explotadas
    batalla.flota_atacante.unidades.delete_if(&:exploto?)
    batalla.flota_defensora.unidades.delete_if(&:exploto?)
  end

end
