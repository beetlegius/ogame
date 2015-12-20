# Cada cuenta puede tener hasta 9 planetas, cada uno se ubica en una posición del 1 al 15 dentro de un sistema.
class Planeta < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  include Campos
  include Temperatura
  include Puntos
  include Recursos

  NOMBRES = %w(Aitedrin Aonadrain Aibeciar Aoligin Eladha Eomiyan Iviise Unoral Ongwin Ealar Aideca Iaroane Otunal Iwedeth Eumam Ibacu Iwociar Uhinin Auceise Ituved Illakaf Ececine Eodadean Arodi Aiyolin Alwyn Morian Ievirind Ovvin Aeveara Autorind Gideth Aunedoc Easolain Adalon Inikir utyn Eunelle Emaarc Autefel Eusoand Eseme Ealiyam Ayachan Aehador Airirel Arilad Aedoine Eumedar Usuta)
  CAMPOS_PLANETA_PRINCIPAL = 163

  before_validation :inicializar, on: :create

  after_create :configurar

  belongs_to :cuenta
  belongs_to :universo

  has_one :luna

  #has_many :edificios, -> { order(:orden) }
  #has_many :minas, -> { mina.order(:orden).activo }, class_name: 'Edificio'
  #has_one :mina_metal
  #has_one :mina_cristal
  #has_one :mina_deuterio
  #has_one :planta_energia
  #has_one :planta_fusion
  #has_one :fabrica_robots
  #has_one :fabrica_nanobots
  #has_one :hangar
  #has_one :almacen_metal
  #has_one :almacen_cristal
  #has_one :almacen_deuterio
  #has_one :laboratorio
  #has_one :silo

  has_many :naves, -> { order(:orden) }
  has_one :carga_chica
  has_one :carga_grande

  #accepts_nested_attributes_for :mina_metal, :mina_cristal, :mina_deuterio, :planta_energia


  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  scope :libre, -> { where cuenta_id: nil }

  validates :nombre, presence: true
  validates :numero_planeta, :uniqueness => { :scope => [:numero_sistema, :numero_galaxia, :universo_id] }

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

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
    edificios.to_a.sum(&:nivel)
  end

  def campos_disponibles?
    cantidad_campos_ocupados < cantidad_campos
  end

  def esta_disponible?
    !cuenta.present?
  end

  def tecnologias_disponibles
    cuenta.tecnologias.select { |tecnologia| nivel_laboratorio >= tecnologia.class.nivel_laboratorio_requerido && tecnologia.cumple_requisitos? }
  end

  #def nivel_laboratorio
  #  laboratorio.nivel # por ahora es así, una vez que esté disponible la red de investigación intergaláctica este cálculo cambiará
  #end

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
    cuenta.puede_investigar_en_simultaneo? && tecnologias_disponibles.include?(tecnologia) && tecnologia.puede_expandirse? && puede_pagar?(tecnologia.metal, tecnologia.cristal, tecnologia.deuterio, tecnologia.energia)
  end

  def puede_construir_en_simultaneo?
    edificios.select(&:esta_expandiendose?).count < universo.cantidad_construcciones_en_simultaneo
  end

  def subir_nivel!(tipo_edificio)
    nivel_edificio = "nivel_#{tipo_edificio}"
    update nivel_edificio => send(nivel_edificio) + 1

  end

  def edificios
   [ mina_metal, mina_cristal, mina_deuterio, planta_energia, planta_fusion, fabrica_robots, fabrica_nanobots, hangar, almacen_metal, almacen_cristal, almacen_deuterio, laboratorio, silo ]
  end

  def minas
    [mina_metal, mina_cristal, mina_deuterio]
  end

  def mina_metal ;        MinaMetal.new         planeta: self, nivel: nivel_mina_metal        ; end
  def mina_cristal ;      MinaCristal.new       planeta: self, nivel: nivel_mina_cristal      ; end
  def mina_deuterio ;     MinaDeuterio.new      planeta: self, nivel: nivel_mina_deuterio     ; end
  def planta_energia ;    PlantaEnergia.new     planeta: self, nivel: nivel_planta_energia    ; end
  def planta_fusion ;     PlantaFusion.new      planeta: self, nivel: nivel_planta_fusion     ; end
  def fabrica_robots ;    FabricaRobots.new     planeta: self, nivel: nivel_fabrica_robots    ; end
  def fabrica_nanobots ;  FabricaNanobots.new   planeta: self, nivel: nivel_fabrica_nanobots  ; end
  def hangar ;            Hangar.new            planeta: self, nivel: nivel_hangar            ; end
  def almacen_metal ;     AlmacenMetal.new      planeta: self, nivel: nivel_almacen_metal     ; end
  def almacen_cristal ;   AlmacenCristal.new    planeta: self, nivel: nivel_almacen_cristal   ; end
  def almacen_deuterio ;  AlmacenDeuterio.new   planeta: self, nivel: nivel_almacen_deuterio  ; end
  def laboratorio ;       Laboratorio.new       planeta: self, nivel: nivel_laboratorio       ; end
  def silo ;              Silo.new              planeta: self, nivel: nivel_silo              ; end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################

  def coordenadas_completas
    "#{numero_galaxia}:#{numero_sistema}:#{numero_planeta}"
  end

  def to_label
    label = "#{nombre} [#{coordenadas_completas}]"
    label += " (principal)" if es_principal?
    label
  end

  alias_method :to_s, :coordenadas_completas

  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def inicializar
    self.nombre ||= NOMBRES.sample
    self.ultima_actualizacion_recursos = Time.now
  end

  # :reek:TooManyStatements: { max_statements: 20 }
  def configurar

    
    update  cantidad_metal:     universo.cantidad_metal_inicial, 
            cantidad_cristal:   universo.cantidad_cristal_inicial, 
            cantidad_deuterio:  universo.cantidad_deuterio_inicial


    #create_mina_metal! orden: 1
    #create_mina_cristal! orden: 2
    #create_mina_deuterio! orden: 3
    #create_planta_energia! orden: 4
    #create_planta_fusion! orden: 5
    #create_fabrica_robots! orden: 6
    #create_fabrica_nanobots! orden: 7
    #create_hangar! orden: 8
    #create_almacen_metal! orden: 9
    #create_almacen_cristal! orden: 10
    #create_almacen_deuterio! orden: 11
    #create_laboratorio! orden: 12
    #create_silo! orden: 13

    create_carga_chica! orden: 1
    create_carga_grande! orden: 2
  end

end
