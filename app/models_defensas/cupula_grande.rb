class CupulaGrande < Defensa

  # CONFIG

  establecer_costos metal: 50000, cristal: 50000
  establecer_fuego_rapido

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def cumple_requisitos?
    propietario.hangar.nivel >= 6 && propietario.cuenta.tecnologia_defensa.nivel >= 6 && super
  end

  # ALIASES

  # PRIVATE METHODS

  private
  
  def configurar
    establecer_caracteristicas estructura: 100000, escudo: 10000, poder: 1
  end

end
