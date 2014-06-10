# El silo se utiliza para almacenar misiles tanto defensivos como ofensivos.
class Silo < Edificio

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 20000, cristal: 20000, deuterio: 1000

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    planeta.hangar.nivel >= 1 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

end
