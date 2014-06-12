# Las minas de metal producen metal.
class MinaMetal < Mina

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 60, cristal: 15
  factor 1.5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def produccion_por_hora
    (30 * nivel * 1.1**nivel).round
  end

  def consumo_energia_base
    10 * nivel * 1.1**nivel
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

end