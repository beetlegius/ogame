# Los jugadores poseen cuentas en varios universos.
class Jugador < ActiveRecord::Base

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  has_many :cuentas
  has_many :universos, through: :cuentas

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################

  validates :nombre, presence: true, uniqueness: true

  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################


  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################

  alias_attribute :to_s, :nombre
  alias_attribute :to_label, :nombre

  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

end
