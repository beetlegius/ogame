# Configuración de permisos
class Ability
  include CanCan::Ability

  def initialize(usuario)
  	usuario ||= nil

    can :manage, :all
  end
end
