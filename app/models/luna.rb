# Las lunas son generadas con cierta probabilidad tras una batalla que deja muchos escombros.
class Luna < ActiveRecord::Base

  # CONFIG

  delegate :cuenta, :coordenadas_completas, to: :planeta

  # CALLBACKS

  # RELATIONS

  belongs_to :planeta, required: true
  has_many :procesos, class_name: '::Delayed::Job', as: :propietario

  # SCOPES

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  def subir_nivel!(edificio)
    increment! edificio.metodo_nivel
  end

  def edificios
    [ fabrica_robots, hangar, base_lunar, sensor_phalanx, salto_cuantico ]
  end

  def fabrica_robots ;    FabricaRobots.new     propietario: self, nivel: nivel_fabrica_robots    ; end
  def hangar ;            Hangar.new            propietario: self, nivel: nivel_hangar            ; end
  def base_lunar ;        BaseLunar.new         propietario: self, nivel: nivel_base_lunar        ; end
  def sensor_phalanx ;    SensorPhalanx.new     propietario: self, nivel: nivel_sensor_phalanx    ; end
  def salto_cuantico ;    SaltoCuantico.new     propietario: self, nivel: nivel_salto_cuantico    ; end

  # ALIASES

  def to_label
    "#{planeta.nombre} [#{coordenadas_completas}] (Luna)"
  end

  alias_method :to_s, :coordenadas_completas

  # PRIVATE METHODS

  private

end
