# Las cuentas son la relación entre los jugadores y los universos. Pueden tener solo una por universo.
class Cuenta < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  after_create :asociar_planeta
  after_create :configurar

  belongs_to :universo
  belongs_to :jugador

  has_many :planetas
  has_many :tecnologias, -> { order(:orden) }
  has_one :tecnologia_espionaje
  has_one :tecnologia_computacion
  has_one :tecnologia_militar
  has_one :tecnologia_defensa
  has_one :tecnologia_blindaje
  has_one :tecnologia_energia
  has_one :tecnologia_hiperespacio
  has_one :tecnologia_combustion
  has_one :tecnologia_impulso
  has_one :tecnologia_propulsor_hiperespacial
  has_one :tecnologia_laser
  has_one :tecnologia_ionica
  has_one :tecnologia_plasma
  has_one :tecnologia_red_investigacion
  has_one :tecnologia_graviton
  has_one :planeta_principal, -> { where es_principal: true }, class_name: 'Planeta'

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validate :espacio_disponible

  validates :universo, :jugador, presence: true
  validates :jugador, uniqueness: { scope: :universo_id }

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

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

  # :reek:TooManyStatements: { max_statements: 15 }
  def configurar
    create_tecnologia_espionaje!                orden: 1
    create_tecnologia_computacion!              orden: 2
    create_tecnologia_militar!                  orden: 3
    create_tecnologia_defensa!                  orden: 4
    create_tecnologia_blindaje!                 orden: 5
    create_tecnologia_energia!                  orden: 6
    create_tecnologia_hiperespacio!             orden: 7
    create_tecnologia_combustion!               orden: 8
    create_tecnologia_impulso!                  orden: 9
    create_tecnologia_propulsor_hiperespacial!  orden: 10
    create_tecnologia_laser!                    orden: 11
    create_tecnologia_ionica!                   orden: 12
    create_tecnologia_plasma!                   orden: 13
    create_tecnologia_red_investigacion!        orden: 14
    create_tecnologia_graviton!                 orden: 15
  end

  def espacio_disponible
    self.errors.add :universo, I18n.t('errors.messages.universo_no_disponible') if universo.esta_lleno?
  end

end
