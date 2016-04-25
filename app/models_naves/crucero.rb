class Crucero < NaveAtaque

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 20000, cristal: 7000, deuterio: 2000
  establecer_fuego_rapido cazador_ligero: 3, lanzamisiles: 10, sonda_espionaje: 5, satelite_solar: 5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 5 && propietario.cuenta.tecnologia_impulso.nivel >= 4 && propietario.cuenta.tecnologia_ionica.nivel >= 2 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 27000, escudo: 50, poder: 400, carga: 800, velocidad: 15000, consumo: 300
  end

end
