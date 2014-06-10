# Un recurso sirve para mejorar un planeta o una tecnología.
class Recurso
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :propietario

  validates :propietario, presence: true

  def initialize(atributos = {})
    @propietario = atributos[:propietario]
  end

	def costo(nivel = nil)
		nivel ||= propietario.nivel
		(costo_base * propietario.class.factor**nivel).floor
	end

end