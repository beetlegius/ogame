class SondaEspionaje < Nave

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos cristal: 1000
  establecer_fuego_rapido

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    propietario.hangar.nivel >= 3 && propietario.cuenta.tecnologia_combustion.nivel >= 3 && propietario.cuenta.tecnologia_espionaje.nivel >= 2 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    establecer_caracteristicas estructura: 1000, escudo: 0.01, poder: 0.01, carga: 5, velocidad: 100000000, consumo: 1
  end

end
