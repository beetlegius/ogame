class MisilInterplanetario < NaveDefensa

  # CONFIG

  establecer_costos metal: 12500, cristal: 2500, deuterio: 10000
  establecer_fuego_rapido

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def cumple_requisitos?
    propietario.silo.nivel >= 4 && super
  end

  # ALIASES

  # PRIVATE METHODS

  private
  
  def configurar
    establecer_caracteristicas estructura: 15000, escudo: 1, poder: 12000
  end

end
