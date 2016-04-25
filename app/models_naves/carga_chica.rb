class CargaChica < NaveAtaque

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 2000, cristal: 2000
  establecer_fuego_rapido sonda_espionaje: 5, satelite_solar: 5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 2 && propietario.cuenta.tecnologia_combustion.nivel >= 2 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def calcular_velocidad
    if propietario.cuenta.tecnologia_combustion.nivel >= 5
      10000 + (2000 * propietario.cuenta.tecnologia_combustion.nivel)
    else
      5000
    end
  end

  def calcular_consumo
    propietario.cuenta.tecnologia_combustion.nivel >= 5 ? 20 : 10
  end

  def configurar
    establecer_caracteristicas estructura: 4000, escudo: 10, poder: 5, carga: 5000, velocidad: calcular_velocidad, consumo: calcular_consumo
  end

end
