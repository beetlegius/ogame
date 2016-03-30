class CanonIonico < Defensa

  # CONFIG

  establecer_costos metal: 2000, cristal: 6000
  establecer_fuego_rapido

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def cumple_requisitos?
    propietario.hangar.nivel >= 4 && propietario.cuenta.tecnologia_ionica.nivel >= 4 && super
  end

  # ALIASES

  # PRIVATE METHODS

  private
  
  def configurar
    establecer_caracteristicas estructura: 8000, escudo: 500, poder: 150
  end

end
