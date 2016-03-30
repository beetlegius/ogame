class CupulaChica < Defensa

  # CONFIG

  establecer_costos metal: 10000, cristal: 10000
  establecer_fuego_rapido

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def cumple_requisitos?
    propietario.hangar.nivel >= 1 && propietario.cuenta.tecnologia_defensa.nivel >= 2 && super
  end

  # ALIASES

  # PRIVATE METHODS

  private
  
  def configurar
    establecer_caracteristicas estructura: 20000, escudo: 2000, poder: 1
  end

end
