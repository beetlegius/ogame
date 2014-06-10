# Existen 9 galaxias por universo.
class Galaxia < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  after_create :configurar

  belongs_to :universo
  has_many :sistemas

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validates :universo, presence: true
  validates :coordenada, presence: true, uniqueness: { scope: :universo_id }

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
    universo.cantidad_sistemas.times do |index|
      sistemas.create! coordenada: index.next
    end
  end

end
