# Las cuentas son la relación entre los jugadores y los universos. Pueden tener solo una por universo.
class Cuenta < ActiveRecord::Base

  # CONFIG

  include Modulos::Tecnologias

  # CALLBACKS

  after_create :asociar_planeta

  # RELATIONS

  belongs_to :universo, required: true
  belongs_to :jugador, required: true

  has_many :cuerpos_celestes
  has_many :planetas
  has_many :lunas
  has_one :planeta_principal, -> { where es_principal: true }, class_name: 'Planeta'

  has_many :procesos, class_name: '::Delayed::Job', as: :propietario

  # SCOPES

  # VALIDATIONS

  validate :espacio_disponible
  validates :jugador, uniqueness: { scope: :universo_id }

  # CLASS METHODS

  # INSTANCE METHODS

  def puede_investigar?
    !planetas.any? { |planeta| planeta.laboratorio.esta_expandiendose? }
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
    cuerpos_celestes.to_a.sum(&:puntos) / 1000
  end

  def subir_nivel!(tecnologia)
    increment! tecnologia.metodo_nivel
  end

  # ALIASES

  # PRIVATE METHODS

  private

  def asociar_planeta
    planeta = universo.crear_planeta_libre!
    planeta.colonizar_como_principal(self) if puede_colonizar? planeta
  end

  def espacio_disponible
    self.errors.add :universo, I18n.t('errors.messages.universo_no_disponible') if universo.esta_lleno?
  end

end
