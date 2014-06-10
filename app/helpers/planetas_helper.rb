module PlanetasHelper

	def costo_faltante(costo, recurso)
    diferencia = costo - recurso
    diferencia = 0 if diferencia < 0
    return number_with_delimiter(diferencia)
  end

end