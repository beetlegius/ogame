module Modulos::Naves

  class NaveCollection
    include ActiveModel::Model
    attr_accessor :collection

    def all
      collection
    end

    def disponible
      @disponible ||= collection.select(&:cumple_requisitos?)
    end

    def procesos
      all.map(&:procesos).flatten.sort_by(&:run_at)
    end

    def fabricando
      all.select(&:esta_fabricandose?) # { |nave| nave.proceso.present? }
    end
  end

  def naves_ataque
    @naves_ataque ||= NaveCollection.new(collection: [ carga_chica, carga_grande, cazador_ligero, cazador_pesado, crucero, colonizador, reciclador, nave_batalla, sonda_espionaje, bombardero, satelite_solar, destructor, estrella_muerte, acorazado ])
  end

  def naves_defensa
    @naves_defensa ||= NaveCollection.new(collection: [ lanzamisiles, laser_chico, laser_grande, canon_ionico, canon_gauss, canon_plasma, cupula_chica, cupula_grande, misil_intercepcion, misil_interplanetario ])
  end

  def carga_chica ;           CargaChica.new            propietario: self, cantidad: cantidad_carga_chica           ; end
  def carga_grande ;          CargaGrande.new           propietario: self, cantidad: cantidad_carga_grande          ; end
  def cazador_ligero ;        CazadorLigero.new         propietario: self, cantidad: cantidad_cazador_ligero        ; end
  def cazador_pesado ;        CazadorPesado.new         propietario: self, cantidad: cantidad_cazador_pesado        ; end
  def crucero ;               Crucero.new               propietario: self, cantidad: cantidad_crucero               ; end
  def colonizador ;           Colonizador.new           propietario: self, cantidad: cantidad_colonizador           ; end
  def reciclador ;            Reciclador.new            propietario: self, cantidad: cantidad_reciclador            ; end
  def nave_batalla ;          NaveBatalla.new           propietario: self, cantidad: cantidad_nave_batalla          ; end
  def sonda_espionaje ;       SondaEspionaje.new        propietario: self, cantidad: cantidad_sonda_espionaje       ; end
  def bombardero ;            Bombardero.new            propietario: self, cantidad: cantidad_bombardero            ; end
  def satelite_solar ;        SateliteSolar.new         propietario: self, cantidad: cantidad_satelite_solar        ; end
  def destructor ;            Destructor.new            propietario: self, cantidad: cantidad_destructor            ; end
  def estrella_muerte ;       EstrellaMuerte.new        propietario: self, cantidad: cantidad_estrella_muerte       ; end
  def acorazado ;             Acorazado.new             propietario: self, cantidad: cantidad_acorazado             ; end

  def lanzamisiles ;          Lanzamisiles.new          propietario: self, cantidad: cantidad_lanzamisiles          ; end
  def laser_chico ;           LaserChico.new            propietario: self, cantidad: cantidad_laser_chico           ; end
  def laser_grande ;          LaserGrande.new           propietario: self, cantidad: cantidad_laser_grande          ; end
  def canon_ionico ;          CanonIonico.new           propietario: self, cantidad: cantidad_canon_ionico          ; end
  def canon_gauss ;           CanonGauss.new            propietario: self, cantidad: cantidad_canon_gauss           ; end
  def canon_plasma ;          CanonPlasma.new           propietario: self, cantidad: cantidad_canon_plasma          ; end
  def cupula_chica ;          CupulaChica.new           propietario: self, cantidad: cantidad_cupula_chica          ; end
  def cupula_grande ;         CupulaGrande.new          propietario: self, cantidad: cantidad_cupula_grande         ; end
  def misil_intercepcion ;    MisilIntercepcion.new     propietario: self, cantidad: cantidad_misil_intercepcion    ; end
  def misil_interplanetario ; MisilInterplanetario.new  propietario: self, cantidad: cantidad_misil_interplanetario ; end

end
