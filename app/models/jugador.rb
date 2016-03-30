# Los jugadores poseen cuentas en varios universos.
class Jugador < ActiveRecord::Base

  # CONFIG

  # CALLBACKS

  # RELATIONS

  has_many :cuentas
  has_many :universos, through: :cuentas

  # SCOPES

  # VALIDATIONS

  validates :nombre, presence: true, uniqueness: true

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIASES

  alias_attribute :to_s, :nombre
  alias_attribute :to_label, :nombre

  # PRIVATE METHODS

  private

end
