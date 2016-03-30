module Modulos::Naves

  def naves
    [ carga_chica, carga_grande, cazador_ligero, cazador_pesado, crucero, colonizador, reciclador, nave_batalla, sonda_espionaje, bombardero, satelite_solar, destructor, estrella_muerte, acorazado ]
  end

  def carga_chica ;      CargaChica.new       propietario: self, cantidad: cantidad_carga_chica     ; end
  def carga_grande ;     CargaGrande.new      propietario: self, cantidad: cantidad_carga_grande    ; end
  def cazador_ligero ;   CazadorLigero.new    propietario: self, cantidad: cantidad_cazador_ligero  ; end
  def cazador_pesado ;   CazadorPesado.new    propietario: self, cantidad: cantidad_cazador_pesado  ; end
  def crucero ;          Crucero.new          propietario: self, cantidad: cantidad_crucero         ; end
  def colonizador ;      Colonizador.new      propietario: self, cantidad: cantidad_colonizador     ; end
  def reciclador ;       Reciclador.new       propietario: self, cantidad: cantidad_reciclador      ; end
  def nave_batalla ;     NaveBatalla.new      propietario: self, cantidad: cantidad_nave_batalla    ; end
  def sonda_espionaje ;  SondaEspionaje.new   propietario: self, cantidad: cantidad_sonda_espionaje ; end
  def bombardero ;       Bombardero.new       propietario: self, cantidad: cantidad_bombardero      ; end
  def satelite_solar ;   SateliteSolar.new    propietario: self, cantidad: cantidad_satelite_solar  ; end
  def destructor ;       Destructor.new       propietario: self, cantidad: cantidad_destructor      ; end
  def estrella_muerte ;  EstrellaMuerte.new   propietario: self, cantidad: cantidad_estrella_muerte ; end
  def acorazado ;        Acorazado.new        propietario: self, cantidad: cantidad_acorazado       ; end

end
