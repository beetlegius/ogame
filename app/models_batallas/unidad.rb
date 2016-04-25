# Class description
class Unidad

  # CONFIG

  include ActiveModel::Model

  attr_accessor :flota, :nave, :estructura, :escudo

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def initialize(*args)
    super
    self.estructura = estructura_maxima
    self.escudo     = escudo_maximo
  end

  def poder
    @poder ||= nave.poder * (10 + flota.cuenta.tecnologia_militar.nivel) / 10
  end

  def estructura_maxima
    @estructura_maxima ||= nave.estructura
  end

  def escudo_maximo
    @escudo_maximo ||= nave.escudo
  end

  def restablecer_escudo
    self.escudo = escudo_maximo
  end

  def exploto?
    escudo.zero? && estructura.zero?
  end

  def podria_explotar?
    escudo.zero? && porcentaje_estructura_sana <= 70
  end

  def porcentaje_estructura_sana
    estructura * 100 / estructura_maxima
  end

  def explotar!
    puts "BOOOOOM con estructura = #{estructura}"
    self.escudo = 0
    self.estructura = 0
    # generar escombros
  end

  def atacar(atacado, ronda)
    # puts "#{nave.tipo} (#{object_id}) dispara a #{atacado.nave.tipo}"
    if atacado.escudo.zero?

      if poder >= atacado.estructura
        atacado.explotar!
      else
        atacado.estructura -= poder
      end

    else
      prc = atacado.escudo_maximo * 0.01
      depleted = (poder / prc).floor
      # puts "PRC = #{prc}"
      # puts "DEPLETED = #{depleted}"
      # puts "DAÑO = #{depleted * prc}"

      if atacado.escudo < (depleted * prc)

        absorbido = atacado.escudo # Acumular daño absorbido
        poder_infligido_restante = poder - atacado.escudo
        if poder_infligido_restante >= atacado.estructura
          atacado.estructura = 0
        else
          atacado.estructura -= poder_infligido_restante
        end

        atacado.escudo = 0

      else
        atacado.escudo -= (depleted * prc)
        absorbido = (depleted * prc) # Acumular daño absorbido
      end

      if atacado.podria_explotar? && (rand(100) >= atacado.porcentaje_estructura_sana)
        atacado.explotar!
      end
      ronda.absorbido[flota.object_id] += absorbido
    end

    return poder
  end

  def debe_disparar_nuevamente?(atacado)
    fuego_rapido = nave.class.fuego_rapido[atacado.nave.tipo.to_sym]
    if fuego_rapido
      probabilidad = 1.0 / fuego_rapido
      rand >= probabilidad
    end
  end

  # ALIASES

  # PRIVATE METHODS

  private

end
