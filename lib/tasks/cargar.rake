def crear_universo(nombre, cantidad_galaxias, cantidad_sistemas, cantidad_planetas, cantidad_planetas_por_cuenta, cantidad_metal_inicial, cantidad_cristal_inicial, cantidad_deuterio_inicial)
	universo = Universo.create! nombre: nombre, cantidad_galaxias: cantidad_galaxias, cantidad_sistemas: cantidad_sistemas, cantidad_planetas: cantidad_planetas, cantidad_planetas_por_cuenta: cantidad_planetas_por_cuenta, cantidad_metal_inicial: cantidad_metal_inicial, cantidad_cristal_inicial: cantidad_cristal_inicial, cantidad_deuterio_inicial: cantidad_deuterio_inicial

	puts universo
	return universo
end

def crear_jugador(nombre)
	jugador = Jugador.create! nombre: nombre
	puts jugador
	return jugador
end

task cargar: :environment do

	universo = crear_universo 'Lite', 3, 9, 15, 9, 30000, 30000, 30000
	# universo = crear_universo 'Andromeda', 9, 499, 9

end

task cuentas: :environment do

	universo = Universo.first
	holyman = crear_jugador 'Holyman'
	gius = crear_jugador 'Gius'
	sxadvi = crear_jugador 'Sxadvi'
	vassili = crear_jugador 'Vassili'

	universo.cuentas.create! [
		{ jugador: holyman },
		{ jugador: gius },
		{ jugador: sxadvi },
		{ jugador: vassili }
	]

end

task reset: :environment do
	for universo in Universo.all
		# Edificio.update_all nivel: 0
		Tecnologia.update_all nivel: 0
		Planeta.update_all cantidad_metal: universo.cantidad_metal_inicial, cantidad_cristal: universo.cantidad_cristal_inicial, cantidad_deuterio: universo.cantidad_deuterio_inicial
	end
end
