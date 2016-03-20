module Modulos::Tecnologias

  def tecnologias
   [ tecnologia_espionaje, tecnologia_computacion, tecnologia_militar, tecnologia_defensa, tecnologia_blindaje, tecnologia_energia, tecnologia_hiperespacio, tecnologia_combustion, tecnologia_impulso, tecnologia_propulsor_hiperespacial, tecnologia_laser, tecnologia_ionica, tecnologia_plasma, tecnologia_red_investigacion, tecnologia_graviton ]
  end

  def tecnologia_espionaje ;                   TecnologiaEspionaje.new               propietario: self, nivel: nivel_tecnologia_espionaje               ; end
  def tecnologia_computacion ;                 TecnologiaComputacion.new             propietario: self, nivel: nivel_tecnologia_computacion             ; end
  def tecnologia_militar ;                     TecnologiaMilitar.new                 propietario: self, nivel: nivel_tecnologia_militar                 ; end
  def tecnologia_defensa ;                     TecnologiaDefensa.new                 propietario: self, nivel: nivel_tecnologia_defensa                 ; end
  def tecnologia_blindaje ;                    TecnologiaBlindaje.new                propietario: self, nivel: nivel_tecnologia_blindaje                ; end
  def tecnologia_energia ;                     TecnologiaEnergia.new                 propietario: self, nivel: nivel_tecnologia_energia                 ; end
  def tecnologia_hiperespacio ;                TecnologiaHiperespacio.new            propietario: self, nivel: nivel_tecnologia_hiperespacio            ; end
  def tecnologia_combustion ;                  TecnologiaCombustion.new              propietario: self, nivel: nivel_tecnologia_combustion              ; end
  def tecnologia_impulso ;                     TecnologiaImpulso.new                 propietario: self, nivel: nivel_tecnologia_impulso                 ; end
  def tecnologia_propulsor_hiperespacial ;     TecnologiaPropulsorHiperespacial.new  propietario: self, nivel: nivel_tecnologia_propulsor_hiperespacial ; end
  def tecnologia_laser ;                       TecnologiaLaser.new                   propietario: self, nivel: nivel_tecnologia_laser                   ; end
  def tecnologia_ionica ;                      TecnologiaIonica.new                  propietario: self, nivel: nivel_tecnologia_ionica                  ; end
  def tecnologia_plasma ;                      TecnologiaPlasma.new                  propietario: self, nivel: nivel_tecnologia_plasma                  ; end
  def tecnologia_red_investigacion ;           TecnologiaRedInvestigacion.new        propietario: self, nivel: nivel_tecnologia_red_investigacion       ; end
  def tecnologia_graviton ;                    TecnologiaGraviton.new                propietario: self, nivel: nivel_tecnologia_graviton                ; end

end
