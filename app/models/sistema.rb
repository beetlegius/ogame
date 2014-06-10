# Hay 499 sistemas por cada galaxia. En cada sistema se puede ubicar hasta 15 planetas.
class Sistema < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  CANTIDAD_PLANETAS = 15

  after_create :configurar

  belongs_to :galaxia
  has_many :planetas

  delegate :universo, to: :galaxia

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validates :galaxia, presence: true
  validates :coordenada, presence: true, uniqueness: { scope: :galaxia_id }

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
    CANTIDAD_PLANETAS.times do |index|
      planeta = planetas.create! coordenada: index.next, cantidad_metal: universo.cantidad_metal_inicial, cantidad_cristal: universo.cantidad_cristal_inicial, cantidad_deuterio: universo.cantidad_deuterio_inicial
      puts planeta.to_label
    end
  end

end
