class NaveDefensa < Nave

  # CONFIG

  attr_accessor :propietario, :cantidad, :estructura, :escudo, :poder

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def establecer_caracteristicas(*args)
    atributos = args.extract_options!
    @estructura = atributos[:estructura] || 0
    @escudo = atributos[:escudo] || 0
    @poder = atributos[:poder] || 0
  end

  # ALIASES

  # PRIVATE METHODS

  private

  def configurar
  end

end
