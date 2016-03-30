class NaveBatalla < Nave

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 45000, cristal: 15000
  establecer_fuego_rapido sonda_espionaje: 5, satelite_solar: 5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 7 && propietario.cuenta.tecnologia_propulsor_hiperespacial.nivel >= 4 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 60000, escudo: 200, poder: 1000, carga: 1500, velocidad: 10000, consumo: 500
  end

end
