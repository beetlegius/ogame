module Campos
  extend ActiveSupport::Concern

  CAMPOS_MINIMO = 40
  CAMPOS_MAXIMO = 310

  included do
    validates :cantidad_campos, inclusion: { in: CAMPOS_MINIMO..CAMPOS_MAXIMO }, allow_nil: true
  end

  def calcular_campos(rango)
    probabilidad = rand(5)
    return rand(CAMPOS_MINIMO..CAMPOS_MAXIMO) if probabilidad.zero?
    rand rango
  end

  def set_campos
    self.cantidad_campos = case coordenada
    when 1..3 then calcular_campos(40..70)
    when 4..6 then calcular_campos(120..310)
    when 7..9 then calcular_campos(105..195)
    when 10..12 then calcular_campos(75..125)
    when 13..15 then calcular_campos(60..190)
    end
  end

end

# Pos 1 -3: 80% entre 40 y 70 Campos ( 55+/-15)
# Pos 4 - 6: 80% entre 120 y 310 Campos (215+/-95)
# Pos 7 - 9: 80% entre 105 y 195 Campos (150+/-45)
# Pos 10 - 12: 80% entre 75 y 125 Campos (100+/-25)
# Pos 13 - 15: 80% entre 60 y 190 Campos (125+/-65)

# Por ejemplo, tienes 80% de posibilidad que el planeta tiene entre 60 y 190
# campos el valor 60 puede tener hasta 125 campos mas y el valor 190
# puede tener hasta 65 campos menos los 20% faltantes puede ser cualquier
# otro tamaño.
