class Bombardero < Nave

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 50000, cristal: 25000, deuterio: 15000
  establecer_fuego_rapido lanzamisiles: 20, laser_chico: 20, laser_grande: 10, canon_ionico: 10, sonda_espionaje: 5, satelite_solar: 5

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 8 && propietario.cuenta.tecnologia_impulso.nivel >= 6 && propietario.cuenta.tecnologia_plasma.nivel >= 5 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def calcular_velocidad
    propietario.cuenta.tecnologia_propulsor_hiperespacial.nivel >= 8 ? 5000 : 4000
  end

  def configurar
    establecer_caracteristicas estructura: 75000, escudo: 500, poder: 1000, carga: 500, velocidad: calcular_velocidad, consumo: 1000
  end

end
