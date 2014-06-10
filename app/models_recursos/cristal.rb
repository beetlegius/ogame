# Recurso cristal
class Cristal < Recurso

	def costo_base
		propietario.class.costo_cristal_base
	end

end