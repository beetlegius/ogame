class MisilIntercepcion < NaveDefensa

  # CONFIG

  establecer_costos metal: 8000, deuterio: 2000
  establecer_fuego_rapido

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def cumple_requisitos?
    propietario.silo.nivel >= 2 && super
  end

  # ALIASES

  # PRIVATE METHODS

  private
  
  def configurar
    establecer_caracteristicas estructura: 8000, escudo: 1, poder: 1
  end

end
