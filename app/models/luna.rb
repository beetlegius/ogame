# Las lunas son generadas con cierta probabilidad tras una batalla que deja muchos escombros.
class Luna < CuerpoCeleste

  # CONFIG

  delegate :coordenadas_completas, to: :planeta

  include Modulos::Edificios::Luna
  include Modulos::Naves

  # CALLBACKS

  # RELATIONS

  belongs_to :planeta, required: true

  # SCOPES

  # VALIDATIONS

  validates :nombre, presence: true

  # CLASS METHODS

  # INSTANCE METHODS

  # :reek:FeatureEnvy: { enabled: false }
  def puede_expandir?(elemento)
    return elemento.puede_expandirse? if elemento.is_a?(Edificio)
  end

  # ALIASES

  def to_label
    "#{planeta.nombre} [#{coordenadas_completas}] (Luna)"
  end

  # PRIVATE METHODS

  private

  def inicializar
    self.nombre ||= 'Luna'
    super
  end

  def configurar
    update! cantidad_metal: 0, cantidad_cristal: 0, cantidad_deuterio: 0
  end

end
