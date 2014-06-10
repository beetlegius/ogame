# Las lunas son generadas con cierta probabilidad tras una batalla que deja muchos escombros.
class Luna < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  after_create :configurar

  belongs_to :planeta

  has_many :edificios
  has_one :fabrica_robots
  has_one :hangar
  has_one :base_lunar
  has_one :sensor_phalanx
  has_one :salto_cuantico

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validates :planeta, presence: true

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################


  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    create_fabrica_robots! orden: 1
    create_hangar! orden: 2
    create_base_lunar! orden: 3
    create_sensor_phalanx! orden: 4
    create_salto_cuantico! orden: 5
  end

end
