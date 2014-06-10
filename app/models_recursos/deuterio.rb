# Recurso deuterio
class Deuterio < Recurso

	def costo_base
		propietario.class.costo_deuterio_base
	end

end