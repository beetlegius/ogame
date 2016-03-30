# Class description
class Batalla

  # CONFIG

  include ActiveModel::Model

  attr_accessor :universo, :flota_atacante, :flota_defensora, :cantidad_rondas, :escombros_metal, :escombros_cristal

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  class << self

    def simular
      batalla = new universo: Universo.first
      batalla.flota_atacante = Flota.atacante
      batalla.flota_defensora = Flota.defensor
      batalla.ejecutar
    end

  end

  # INSTANCE METHODS

  def initialize(*args)
    super
    self.cantidad_rondas = universo.cantidad_rondas_en_batallas
  end

  def ejecutar
    cantidad_rondas.times { |i| ejecutar_ronda(i) }
    return resultado
  end


  # ALIASES

  # PRIVATE METHODS

  private

  def ejecutar_ronda(numero = 0)
    return if debe_finalizar?
    puts "COMIENZA RONDA ##{numero.next}"

    restablecer_estadisticas
    cargar_escudos

    for unidad in flota_atacante.unidades
      disparar(unidad, flota_defensora.unidades)
    end

    for unidad in flota_defensora.unidades
      disparar(unidad, flota_atacante.unidades)
    end

    eliminar_explotadas
  end

  def debe_finalizar?
    # puts 'chequear si la batalla debe terminar'
    flota_atacante.destruido? || flota_defensora.destruido?
  end

  def restablecer_estadisticas
    # puts 'Restablecer estadísticas (disparos y daño absorbido)'
  end

  def cargar_escudos
    flota_atacante.unidades.each(&:restablecer_escudo)
    flota_defensora.unidades.each(&:restablecer_escudo)
  end

  def disparar(atacante, defensores)
    # puts 'Disparan atacantes y luego defensores'
    # puts '-> Elije un objetivo al azar de entre los defensores'
    # puts '-> Disparar'
    # puts '-> -> Determinar si la unidad explota o no'
    # puts '-> Recalcula fuego rápido'

    defensor = defensores.sample

    return if defensor.exploto?
    atacante.atacar(defensor)
    # Recalcular fuego rápido
  end

  def eliminar_explotadas
    # puts 'Eliminar unidades explotadas'
    flota_atacante.unidades.delete_if(&:exploto?)
    flota_defensora.unidades.delete_if(&:exploto?)
  end

  def resultado
    puts 'Resultado de la batalla'
    puts "GANO ATACANTE" if flota_defensora.destruido?
    puts "GANO DEFENSOR" if flota_atacante.destruido?
    puts "EMPATE" if !flota_atacante.destruido? && !flota_defensora.destruido?
  end

end
