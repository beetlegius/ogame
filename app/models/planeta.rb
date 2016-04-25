# Cada cuenta puede tener hasta 9 planetas, cada uno se ubica en una posición del 1 al 15 dentro de un sistema.
class Planeta < CuerpoCeleste

  # CONFIG

  include Campos
  include Temperatura
  include Puntos
  include Recursos

  include Modulos::Edificios::Planeta
  include Modulos::Naves

  NOMBRES = %w(Aitedrin Aonadrain Aibeciar Aoligin Eladha Eomiyan Iviise Unoral Ongwin Ealar Aideca Iaroane Otunal Iwedeth Eumam Ibacu Iwociar Uhinin Auceise Ituved Illakaf Ececine Eodadean Arodi Aiyolin Alwyn Morian Ievirind Ovvin Aeveara Autorind Gideth Aunedoc Easolain Adalon Inikir utyn Eunelle Emaarc Autefel Eusoand Eseme Ealiyam Ayachan Aehador Airirel Arilad Aedoine Eumedar Usuta)
  CAMPOS_PLANETA_PRINCIPAL = 163

  # CALLBACKS

  # RELATIONS

  has_one :luna

  # SCOPES

  scope :libre, -> { where cuenta_id: nil }
  scope :ubicacion, -> (galaxia, sistema) { where numero_galaxia: galaxia, numero_sistema: sistema }

  # VALIDATIONS

  validates :numero_planeta, uniqueness: { scope: [:numero_sistema, :numero_galaxia, :universo_id] }

  # CLASS METHODS

  # INSTANCE METHODS

  def colonizar_como_principal(cuenta)
    self.es_principal = true
    self.cuenta = cuenta
    self.cantidad_campos = CAMPOS_PLANETA_PRINCIPAL

    set_temperaturas
    save!
  end

  def colonizar(cuenta)
    self.cuenta = cuenta

    set_temperaturas
    set_campos
    save!
  end

  def imagen_name
    temperatura_maxima.to_i % 26
  end

  def diametro
    (Math.sqrt(cantidad_campos) * 1000).round
  end

  # Indica si el planeta dispone de campos
  def cantidad_campos_ocupados
    edificios.sum(&:nivel)
  end

  def campos_disponibles?
    cantidad_campos_ocupados < cantidad_campos
  end

  # Este método debería morir porque los planetas se crearían al colonizarlos
  def esta_disponible?
    !cuenta.present?
  end

  # Reformar como naves con clase NaveCollection
  def edificios_disponibles
    edificios.select(&:cumple_requisitos?)
  end

  # Reformar como naves con NaveCollection
  def tecnologias_disponibles
    cuenta.tecnologias.select { |tecnologia| nivel_laboratorio >= tecnologia.class.nivel_laboratorio_requerido && tecnologia.cumple_requisitos? }
  end

  # def nivel_laboratorio
  #   laboratorio.nivel # por ahora es así, una vez que esté disponible la red de investigación intergaláctica este cálculo cambiará
  # end

  ##############################################################################
  ########################### EDIFICIOS Y TECNOLOGIAS ##########################
  ##############################################################################

  # :reek:FeatureEnvy: { enabled: false }
  def puede_expandir?(elemento)
    return elemento.puede_expandirse? if elemento.is_a?(Edificio)
    return puede_investigar?(elemento) if elemento.is_a?(Tecnologia)
  end

  # :reek:FeatureEnvy: { enabled: false }
  def puede_investigar?(tecnologia)
    cuenta.puede_investigar? && cuenta.puede_investigar_en_simultaneo? && tecnologias_disponibles.map(&:tipo).include?(tecnologia.tipo) && tecnologia.puede_expandirse? && puede_pagar?(tecnologia.metal, tecnologia.cristal, tecnologia.deuterio, tecnologia.energia)
  end

  # ALIASES

  def coordenadas_completas
    "#{numero_galaxia}:#{numero_sistema}:#{numero_planeta}"
  end

  def to_label
    label = "#{nombre} [#{coordenadas_completas}]"
    label += " (principal)" if es_principal?
    label
  end

  # PRIVATE METHODS

  private

  def inicializar
    self.nombre ||= NOMBRES.sample
    super
  end

  def configurar
    update! cantidad_metal:    universo.cantidad_metal_inicial,
            cantidad_cristal:  universo.cantidad_cristal_inicial,
            cantidad_deuterio: universo.cantidad_deuterio_inicial
  end

end
