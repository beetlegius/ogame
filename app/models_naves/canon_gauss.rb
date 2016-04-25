class CanonGauss < NaveDefensa

  # CONFIG

  establecer_costos metal: 20000, cristal: 15000, deuterio: 2000
  establecer_fuego_rapido

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def cumple_requisitos?
    propietario.hangar.nivel >= 6 && propietario.cuenta.tecnologia_energia.nivel >= 6 && propietario.cuenta.tecnologia_militar.nivel >= 3 && propietario.cuenta.tecnologia_defensa.nivel >= 1 && super
  end

  # ALIASES

  # PRIVATE METHODS

  private

  def configurar
    establecer_caracteristicas estructura: 35000, escudo: 200, poder: 1100
  end

end
