class CazadorPesado < NaveAtaque

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 6000, cristal: 4000
  establecer_fuego_rapido carga_chica: 3, sonda_espionaje: 5, satelite_solar: 5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 3 && propietario.cuenta.tecnologia_blindaje.nivel >= 2 && propietario.cuenta.tecnologia_impulso.nivel >= 2 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 10000, escudo: 25, poder: 150, carga: 100, velocidad: 10000, consumo: 75
  end

end
