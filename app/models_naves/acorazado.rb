class Acorazado < NaveAtaque

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 30000, cristal: 40000, deuterio: 15000
  establecer_fuego_rapido sonda_espionaje: 5, satelite_solar: 5, carga_chica: 3, cazador_pesado: 4, carga_grande: 3, crucero: 4, batalla: 7

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 8 && propietario.cuenta.tecnologia_hiperespacio.nivel >= 5 && propietario.cuenta.tecnologia_laser.nivel >= 12 && propietario.cuenta.tecnologia_propulsor_hiperespacial.nivel >= 5 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 70000, escudo: 400, poder: 700, carga: 750, velocidad: 10000, consumo: 250
  end

end
