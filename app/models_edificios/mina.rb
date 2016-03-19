# Las minas producen recursos.
class Mina < Edificio

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  attr_accessor :porcentaje_produccion

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validates :porcentaje_produccion, presence: true, inclusion: { in: PORCENTAJES_PRODUCCION }

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def produccion
    produccion_activa * cantidad_segundos_producidos * indice_energia_disponible
  end

  def produccion_activa_por_hora
    (indice_energia_disponible * produccion_por_hora * porcentaje_produccion / 100).round
  end

  def consumo_energia
    (consumo_energia_base * porcentaje_produccion / 100).round
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def produccion_activa
    produccion_por_segundo * porcentaje_produccion / 100
  end

  def cantidad_segundos_producidos
    (Time.now - propietario.ultima_actualizacion_recursos).round
  end

  def indice_energia_disponible
    return 1 if propietario.recurso_energia_disponible >= 0
    return 0 if consumo_energia.zero?

    energia_disponible = consumo_energia.to_f * propietario.recurso_energia.to_f / propietario.recurso_energia_consumida.to_f

    energia_disponible.to_f / consumo_energia.to_f
  end

  def produccion_por_segundo
    produccion_por_hora.to_f / 3600
  end

  def produccion_por_hora_disponible
    produccion_por_hora.to_f * indice_energia_disponible
  end

end
