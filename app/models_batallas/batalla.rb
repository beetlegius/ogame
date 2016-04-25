# Class description
class Batalla

  # CONFIG

  include ActiveModel::Model

  attr_accessor :universo, :flota_atacante, :flota_defensora, :rondas, :escombros_metal, :escombros_cristal

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
      # return batalla
    end

  end

  # INSTANCE METHODS

  def initialize(*args)
    super
    self.rondas = []
  end

  def ejecutar
    universo.cantidad_rondas_en_batallas.times do |i|
      return resultado if debe_finalizar?
      ronda = Ronda.new(batalla: self, numero: i.next)
      rondas << ronda
      ronda.ejecutar
    end
    flotas.each &:post_batalla
    resultado
  end

  # ALIASES

  # PRIVATE METHODS

  private

  def debe_finalizar?
    # puts 'chequear si la batalla debe terminar'
    flota_atacante.destruido? || flota_defensora.destruido?
  end

  def resultado
    puts 'Resultado de la batalla'
    puts "GANO ATACANTE" if flota_defensora.destruido?
    puts "GANO DEFENSOR" if flota_atacante.destruido?
    puts "EMPATE" if !flota_atacante.destruido? && !flota_defensora.destruido?
  end

end
