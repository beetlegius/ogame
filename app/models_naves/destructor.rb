class Destructor < NaveAtaque

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 60000, cristal: 50000, deuterio: 15000
  establecer_fuego_rapido laser_chico: 10, sonda_espionaje: 5, satelite_solar: 5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 9 && propietario.cuenta.tecnologia_hiperespacio.nivel >= 5 && propietario.cuenta.tecnologia_propulsor_hiperespacial.nivel >= 6 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 110000, escudo: 500, poder: 2000, carga: 2000, velocidad: 5000, consumo: 1000
  end

end
