# Cada cuenta puede tener hasta 9 planetas, cada uno se ubica en una posición del 1 al 15 dentro de un sistema.
class Planeta < ActiveRecord::Base

  # CONFIG

  include Campos
  include Temperatura
  include Puntos
  include Recursos

  include Modulos::Edificios
  include Modulos::Naves
  include Modulos::Defensas

  NOMBRES = %w(Aitedrin Aonadrain Aibeciar Aoligin Eladha Eomiyan Iviise Unoral Ongwin Ealar Aideca Iaroane Otunal Iwedeth Eumam Ibacu Iwociar Uhinin Auceise Ituved Illakaf Ececine Eodadean Arodi Aiyolin Alwyn Morian Ievirind Ovvin Aeveara Autorind Gideth Aunedoc Easolain Adalon Inikir utyn Eunelle Emaarc Autefel Eusoand Eseme Ealiyam Ayachan Aehador Airirel Arilad Aedoine Eumedar Usuta)
  CAMPOS_PLANETA_PRINCIPAL = 163

  # CALLBACKS

  after_initialize :inicializar
  after_create :configurar

  # RELATIONS

  belongs_to :cuenta
  belongs_to :universo, required: true

  has_one :luna

  has_many :procesos, class_name: '::Delayed::Job', as: :propietario

  # SCOPES

  scope :libre, -> { where cuenta_id: nil }
  scope :ubicacion, -> (galaxia, sistema) { where numero_galaxia: galaxia, numero_sistema: sistema }

  # VALIDATIONS

  validates :nombre, presence: true
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

  def edificios_disponibles
    edificios.select(&:cumple_requisitos?)
  end

  def tecnologias_disponibles
    cuenta.tecnologias.select { |tecnologia| nivel_laboratorio >= tecnologia.class.nivel_laboratorio_requerido && tecnologia.cumple_requisitos? }
  end

  def naves_disponibles
    naves.select(&:cumple_requisitos?)
  end

  def defensas_disponibles
    defensas.select(&:cumple_requisitos?)
  end

  # def nivel_laboratorio
  #   laboratorio.nivel # por ahora es así, una vez que esté disponible la red de investigación intergaláctica este cálculo cambiará
  # end

  ##############################################################################
  ########################### NAVES ############################################
  ##############################################################################

  def cantidad_maxima_fabricacion(fabricable)
    cantidad_maxima_metal = recurso_metal / fabricable.metal.costo if fabricable.metal.costo > 0
    cantidad_maxima_cristal = recurso_cristal / fabricable.cristal.costo if fabricable.cristal.costo > 0
    cantidad_maxima_deuterio = recurso_deuterio / fabricable.deuterio.costo if fabricable.deuterio.costo > 0
    [cantidad_maxima_metal, cantidad_maxima_cristal, cantidad_maxima_deuterio].compact.min
  end

  def puede_fabricar?(fabricable)
    hangar.proceso.nil? && cantidad_maxima_fabricacion(fabricable) > 0
  end

  def procesos_de_naves
    naves.map(&:procesos).flatten.sort_by(&:created_at)
  end

  def naves_en_fabricacion
    naves.select { |nave| nave.proceso.present? }
  end

  ##############################################################################
  ########################### EDIFICIOS Y TECNOLOGIAS###########################
  ##############################################################################

  # :reek:FeatureEnvy: { enabled: false }
  def puede_expandir?(elemento)
    return elemento.puede_expandirse? if elemento.is_a?(Edificio)
    return puede_investigar?(elemento) if elemento.is_a?(Tecnologia)
  end

  def puede_construir?
    cuenta.present? && campos_disponibles? && puede_construir_en_simultaneo?
  end

  # :reek:FeatureEnvy: { enabled: false }
  def puede_investigar?(tecnologia)
    cuenta.puede_investigar_en_simultaneo? && tecnologias_disponibles.map(&:tipo).include?(tecnologia.tipo) && tecnologia.puede_expandirse? && puede_pagar?(tecnologia.metal, tecnologia.cristal, tecnologia.deuterio, tecnologia.energia)
  end

  def puede_construir_en_simultaneo?
    edificios.select(&:esta_expandiendose?).count < universo.cantidad_construcciones_en_simultaneo
  end

  def subir_nivel!(edificio)
    increment! edificio.metodo_nivel
  end

  def sumar_nave!(nave)
    increment! nave.metodo_cantidad
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

  alias_method :to_s, :coordenadas_completas

  # PRIVATE METHODS

  private

  def inicializar
    self.nombre ||= NOMBRES.sample
    self.ultima_actualizacion_recursos ||= Time.now
  end

  def configurar
    update! cantidad_metal:    universo.cantidad_metal_inicial,
            cantidad_cristal:  universo.cantidad_cristal_inicial,
            cantidad_deuterio: universo.cantidad_deuterio_inicial
  end

end
