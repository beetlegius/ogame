# Las plantas de fusión producen energía pero consumen deuterio.
class PlantaFusion < Edificio

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  attr_accessor :porcentaje_produccion

  establecer_costos metal: 900, cristal: 360, deuterio: 180
  factor 1.5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.cuenta.tecnologia_energia.nivel >= 3 && propietario.mina_deuterio.nivel >= 5 && super
  end

  def produccion
    (30 * nivel * (0.01 * propietario.cuenta.tecnologia_energia.nivel + 1.05)**nivel).round
  end

  def consumo_deuterio_hora
    (10 * nivel * 1.1**nivel).round
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

end
