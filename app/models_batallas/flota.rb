# Class description
class Flota

  # CONFIG

  include ActiveModel::Model

  attr_accessor :naves, :unidades, :cuenta

  # CALLBACKS

  # RELATIONS

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  class << self

    def atacante
      cuenta = Cuenta.first
      new naves: cuenta.planetas.first.naves, cuenta: cuenta
    end

    def defensor
      cuenta = Cuenta.last
      new naves: cuenta.planetas.first.naves, cuenta: cuenta
    end

  end

  # INSTANCE METHODS

  def initialize(*args)
    super
    self.unidades = []
    for nave in naves
      nave.cantidad.times do
        self.unidades << Unidad.new(flota: self, nave: nave)
      end
    end
  end

  def post_batalla
    # Actualizar cantidad restante en cada flota
  end

  def destruido?
    unidades.empty?
  end

  # ALIASES

  # PRIVATE METHODS

  private

end
