class Reciclador < NaveAtaque

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 10000, cristal: 6000, deuterio: 2000
  establecer_fuego_rapido sonda_espionaje: 5, satelite_solar: 5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 4 && propietario.cuenta.tecnologia_combustion.nivel >= 6 && propietario.cuenta.tecnologia_defensa.nivel >= 2 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 16000, escudo: 10, poder: 1, carga: 20000, velocidad: 2000, consumo: 300
  end

end
