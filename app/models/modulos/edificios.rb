module Modulos::Edificios

  module Planeta
    
    def edificios
      [ mina_metal, mina_cristal, mina_deuterio, planta_energia, planta_fusion, fabrica_robots, fabrica_nanobots, hangar, almacen_metal, almacen_cristal, almacen_deuterio, laboratorio, silo ]
    end

    def minas
      [ mina_metal, mina_cristal, mina_deuterio ]
    end

    def mina_metal ;        MinaMetal.new         propietario: self, nivel: nivel_mina_metal,     porcentaje_produccion: porcentaje_produccion_mina_metal     ; end
    def mina_cristal ;      MinaCristal.new       propietario: self, nivel: nivel_mina_cristal,   porcentaje_produccion: porcentaje_produccion_mina_cristal   ; end
    def mina_deuterio ;     MinaDeuterio.new      propietario: self, nivel: nivel_mina_deuterio,  porcentaje_produccion: porcentaje_produccion_mina_deuterio  ; end
    def planta_energia ;    PlantaEnergia.new     propietario: self, nivel: nivel_planta_energia, porcentaje_produccion: porcentaje_produccion_planta_energia ; end
    def planta_fusion ;     PlantaFusion.new      propietario: self, nivel: nivel_planta_fusion,  porcentaje_produccion: porcentaje_produccion_planta_fusion  ; end
    def fabrica_robots ;    FabricaRobots.new     propietario: self, nivel: nivel_fabrica_robots    ; end
    def fabrica_nanobots ;  FabricaNanobots.new   propietario: self, nivel: nivel_fabrica_nanobots  ; end
    def hangar ;            Hangar.new            propietario: self, nivel: nivel_hangar            ; end
    def almacen_metal ;     AlmacenMetal.new      propietario: self, nivel: nivel_almacen_metal     ; end
    def almacen_cristal ;   AlmacenCristal.new    propietario: self, nivel: nivel_almacen_cristal   ; end
    def almacen_deuterio ;  AlmacenDeuterio.new   propietario: self, nivel: nivel_almacen_deuterio  ; end
    def laboratorio ;       Laboratorio.new       propietario: self, nivel: nivel_laboratorio       ; end
    def silo ;              Silo.new              propietario: self, nivel: nivel_silo              ; end
  end

  module Luna
    def edificios
      [ fabrica_robots, hangar, base_lunar, sensor_phalanx, salto_cuantico ]
    end

    def fabrica_robots ;    FabricaRobots.new     propietario: self, nivel: nivel_fabrica_robots    ; end
    def hangar ;            Hangar.new            propietario: self, nivel: nivel_hangar            ; end
    def base_lunar ;        BaseLunar.new         propietario: self, nivel: nivel_base_lunar        ; end
    def sensor_phalanx ;    SensorPhalanx.new     propietario: self, nivel: nivel_sensor_phalanx    ; end
    def salto_cuantico ;    SaltoCuantico.new     propietario: self, nivel: nivel_salto_cuantico    ; end
  end

end
