# Recurso metal
class Metal < Recurso

	def costo_base
		propietario.class.costo_metal_base
	end

end