# Las minas de deuterio producen deuterio.
class MinaDeuterio < Mina

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 225, cristal: 75
  factor 1.5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def produccion_por_hora
    (10 * nivel * 1.1**nivel * (-0.002 * planeta.temperatura_maxima + 1.28)).round
  end

  def consumo_energia_base
    20 * nivel * 1.1**nivel
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

end