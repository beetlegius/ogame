class SateliteSolar < NaveAtaque

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos cristal: 2000, deuterio: 500
  establecer_fuego_rapido

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 1 && super
  end

  def produccion
    [(propietario.temperatura_maxima.to_f / 4 + 20).floor, 1].max * cantidad
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 2000, escudo: 1, poder: 1, carga: 0, velocidad: 0, consumo: 0
  end

end
