# Las cuentas son la relación entre los jugadores y los universos. Pueden tener solo una por universo.
class Cuenta < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  after_create :asociar_planeta

  belongs_to :universo, required: true
  belongs_to :jugador, required: true

  has_many :planetas
  has_many :lunas, through: :planetas
  has_one :planeta_principal, -> { where es_principal: true }, class_name: 'Planeta'

  has_many :procesos, class_name: '::Delayed::Job', as: :propietario

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validate :espacio_disponible
  validates :jugador, uniqueness: { scope: :universo_id }

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  # Queda a revisión
  def planetas_disponibles
    planetas + lunas
  end

  def puede_investigar_en_simultaneo?
    tecnologias.select(&:esta_expandiendose?).count < universo.cantidad_investigaciones_en_simultaneo
  end

  # EN VEZ DE PLANETA, DEBE RECIBIR COORDENADA, LOS PLANETAS SE CREAN AL COLONIZARSE
  def colonizar(planeta)
    planeta.colonizar(self) if puede_colonizar? planeta
  end

  def puede_colonizar?(planeta)
    planeta.esta_disponible? && planetas.count < universo.cantidad_planetas_por_cuenta
  end

  # SI LA CUENTA ESTÁ PROTEGIDA, PUEDO ATACARLA SI EL 20% DE MIS PUNTOS NO SUPERAN EL PUNTAJE DE ESA CUENTA Y VICEVERSA
  def puede_atacar_a?(una_cuenta)
    return false if una_cuenta == self
    return true if !una_cuenta.esta_protegida?

    puntos_contrincante = una_cuenta.puntos
    puntos * 0.2 < puntos_contrincante && puntos_contrincante * 0.2 < puntos
  end

  def esta_protegida?
    puntos < universo.puntos_protegidos
  end

  def puntos
    planetas.to_a.sum(&:puntos) / 1000
  end

  def tecnologias
   [ tecnologia_espionaje, tecnologia_computacion, tecnologia_militar, tecnologia_defensa, tecnologia_blindaje, tecnologia_energia, tecnologia_hiperespacio, tecnologia_combustion, tecnologia_impulso, tecnologia_propulsor_hiperespacial, tecnologia_laser, tecnologia_ionica, tecnologia_plasma, tecnologia_red_investigacion, tecnologia_graviton ]
  end

  def tecnologia_espionaje ;                   TecnologiaEspionaje.new               propietario: self, nivel: nivel_tecnologia_espionaje               ; end
  def tecnologia_computacion ;                 TecnologiaComputacion.new             propietario: self, nivel: nivel_tecnologia_computacion             ; end
  def tecnologia_militar ;                     TecnologiaMilitar.new                 propietario: self, nivel: nivel_tecnologia_militar                 ; end
  def tecnologia_defensa ;                     TecnologiaDefensa.new                 propietario: self, nivel: nivel_tecnologia_defensa                 ; end
  def tecnologia_blindaje ;                    TecnologiaBlindaje.new                propietario: self, nivel: nivel_tecnologia_blindaje                ; end
  def tecnologia_energia ;                     TecnologiaEnergia.new                 propietario: self, nivel: nivel_tecnologia_energia                 ; end
  def tecnologia_hiperespacio ;                TecnologiaHiperespacio.new            propietario: self, nivel: nivel_tecnologia_hiperespacio            ; end
  def tecnologia_combustion ;                  TecnologiaCombustion.new              propietario: self, nivel: nivel_tecnologia_combustion              ; end
  def tecnologia_impulso ;                     TecnologiaImpulso.new                 propietario: self, nivel: nivel_tecnologia_impulso                 ; end
  def tecnologia_propulsor_hiperespacial ;     TecnologiaPropulsorHiperespacial.new  propietario: self, nivel: nivel_tecnologia_propulsor_hiperespacial ; end
  def tecnologia_laser ;                       TecnologiaLaser.new                   propietario: self, nivel: nivel_tecnologia_laser                   ; end
  def tecnologia_ionica ;                      TecnologiaIonica.new                  propietario: self, nivel: nivel_tecnologia_ionica                  ; end
  def tecnologia_plasma ;                      TecnologiaPlasma.new                  propietario: self, nivel: nivel_tecnologia_plasma                  ; end
  def tecnologia_red_investigacion ;           TecnologiaRedInvestigacion.new        propietario: self, nivel: nivel_tecnologia_red_investigacion       ; end
  def tecnologia_graviton ;                    TecnologiaGraviton.new                propietario: self, nivel: nivel_tecnologia_graviton                ; end

  def subir_nivel!(tecnologia)
    increment! tecnologia.metodo_nivel
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def asociar_planeta
    planeta = universo.crear_planeta_libre!
    planeta.colonizar_como_principal(self) if puede_colonizar? planeta
  end

  def espacio_disponible
    self.errors.add :universo, I18n.t('errors.messages.universo_no_disponible') if universo.esta_lleno?
  end

end
