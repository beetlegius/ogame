# Suma el nivel de laboratorio de varios planetas, logrando así reducir el tiempo de investigación de las tecnologías.
class TecnologiaRedInvestigacion < Tecnologia

  ##############################################################################
  #### CONFIGURACIONES Y RELACIONES
  ##############################################################################

  establecer_costos metal: 240000, cristal: 400000, deuterio: 160000
  requiere_laboratorio 10

  ##############################################################################
  #### SCOPES Y VALIDACIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PÚBLICOS
  ##############################################################################

  def cumple_requisitos?
    cuenta.tecnologia_computacion.nivel >= 8 && cuenta.tecnologia_hiperespacio.nivel >= 8 && super
  end

  ##############################################################################
  #### ALIAS E IMPRESIONES
  ##############################################################################


  ##############################################################################
  #### MÉTODOS PRIVADOS
  ##############################################################################

  private

end
