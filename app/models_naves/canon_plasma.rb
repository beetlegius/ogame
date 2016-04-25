class CanonPlasma < NaveDefensa

  # CONFIG

  establecer_costos metal: 50000, cristal: 50000, deuterio: 30000
  establecer_fuego_rapido

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def cumple_requisitos?
    propietario.hangar.nivel >= 8 && propietario.cuenta.tecnologia_plasma.nivel >= 7 && super
  end

  # ALIASES

  # PRIVATE METHODS

  private
  
  def configurar
    establecer_caracteristicas estructura: 100000, escudo: 300, poder: 3000
  end

end
