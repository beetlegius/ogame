# Los universos se pueden configurar. Cada universo posee 9 galaxias.
class Universo < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  after_create :configurar

  has_many :galaxias
  has_many :sistemas, through: :galaxias
  has_many :planetas, through: :sistemas

  has_many :cuentas
	has_many :jugadores, through: :cuentas

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

	validates :nombre, presence: true, uniqueness: true

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def ranking
    cuentas.to_a.sort_by(&:puntos).reverse
  end

  def esta_lleno?
    planetas.libre.count < cantidad_planetas_por_cuenta
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################

  alias_attribute :to_s, :nombre
  alias_attribute :to_label, :nombre

  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

  def configurar
    cantidad_galaxias.times do |index|
      galaxias.create! coordenada: index.next
    end
  end
  handle_asynchronously :configurar

end
