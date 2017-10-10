def crear_universo(nombre, cantidad_galaxias, cantidad_sistemas, cantidad_planetas, cantidad_planetas_por_cuenta, cantidad_metal_inicial, cantidad_cristal_inicial, cantidad_deuterio_inicial, cantidad_rondas_en_batallas)
	universo = Universo.create! nombre: nombre, cantidad_galaxias: cantidad_galaxias, cantidad_sistemas: cantidad_sistemas, cantidad_planetas: cantidad_planetas, cantidad_planetas_por_cuenta: cantidad_planetas_por_cuenta, cantidad_metal_inicial: cantidad_metal_inicial, cantidad_cristal_inicial: cantidad_cristal_inicial, cantidad_deuterio_inicial: cantidad_deuterio_inicial, cantidad_rondas_en_batallas: cantidad_rondas_en_batallas

	puts universo
	return universo
end

def crear_jugador(nombre)
	jugador = Jugador.create! nombre: nombre
	puts jugador
	return jugador
end

task cargar: :environment do

	universo = crear_universo 'Lite', 3, 9, 15, 9, 30000, 30000, 30000, 6
	# universo = crear_universo 'Andromeda', 9, 499, 9

end

task cuentas: :environment do

	universo = Universo.first
	holyman = crear_jugador 'Holyman'
	gius = crear_jugador 'Gius'

	universo.cuentas.create! [
		{ jugador: holyman },
		{ jugador: gius }
	]

end

task reset: :environment do
	for universo in Universo.all
		Planeta.update_all cantidad_metal: universo.cantidad_metal_inicial, cantidad_cristal: universo.cantidad_cristal_inicial, cantidad_deuterio: universo.cantidad_deuterio_inicial
	end
end

task inicializar: :environment do
	Rake::Task['cargar'].invoke
	Rake::Task['cuentas'].invoke
end
