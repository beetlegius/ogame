class EstrellaMuerte < Nave

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 5000000, cristal: 4000000, deuterio: 1000000
  establecer_fuego_rapido carga_chica: 250, carga_grande: 250, cazador_ligero: 200, cazador_pesado: 100, crucero: 33, batalla: 30, colonizador: 250, reciclador: 250, bombardero: 25, destructor: 5, lanzamisiles: 200, laser_chico: 200, laser_grande: 100, canon_gauss: 50, canon_ionico: 100, sonda_espionaje: 1250, satelite_solar: 1250

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 12 && propietario.cuenta.tecnologia_hiperespacio.nivel >= 6 && propietario.cuenta.tecnologia_propulsor_hiperespacial.nivel >= 7 && propietario.cuenta.tecnologia_graviton.nivel >= 1 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 9000000, escudo: 50000, poder: 200000, carga: 1000000, velocidad: 100, consumo: 1
  end

end
