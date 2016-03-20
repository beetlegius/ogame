module Modulos::Defensas

  def defensas
    [ lanzamisiles, laser_chico, laser_grande, canon_ionico, canon_gauss, canon_plasma, cupula_chica, cupula_grande, misil_intercepcion, misil_interplanetario ]
  end

  def lanzamisiles ;          Lanzamisiles.new          propietario: self, cantidad: cantidad_defensa_lanzamisiles          ; end
  def laser_chico ;           LaserChico.new            propietario: self, cantidad: cantidad_defensa_laser_chico           ; end
  def laser_grande ;          LaserGrande.new           propietario: self, cantidad: cantidad_defensa_laser_grande          ; end
  def canon_ionico ;          CanonIonico.new           propietario: self, cantidad: cantidad_defensa_canon_ionico          ; end
  def canon_gauss ;           CanonGauss.new            propietario: self, cantidad: cantidad_defensa_canon_gauss           ; end
  def canon_plasma ;          CanonPlasma.new           propietario: self, cantidad: cantidad_defensa_canon_plasma          ; end
  def cupula_chica ;          CupulaChica.new           propietario: self, cantidad: cantidad_defensa_cupula_chica          ; end
  def cupula_grande ;         CupulaGrande.new          propietario: self, cantidad: cantidad_defensa_cupula_grande         ; end
  def misil_intercepcion ;    MisilIntercepcion.new     propietario: self, cantidad: cantidad_defensa_misil_intercepcion    ; end
  def misil_interplanetario ; MisilInterplanetario.new  propietario: self, cantidad: cantidad_defensa_misil_interplanetario ; end

end
