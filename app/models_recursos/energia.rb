# Recurso energía
class Energia < Recurso

	def costo_base
		propietario.class.costo_energia_base
	end

end