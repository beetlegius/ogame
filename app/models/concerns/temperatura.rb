module Temperatura
  extend ActiveSupport::Concern

  DIFERENCIA_TEMPERATURAS = 40

  def calcular_temperatura_minima
    case coordenada
    when 1..3 then rand(100..120)
    when 4..6 then rand(60..90)
    when 7..9 then rand(30..60)
    when 10..12 then rand(0..30)
    when 13..15 then rand(-30..0)
    end
  end

  def set_temperaturas
    self.temperatura_minima = calcular_temperatura_minima
    self.temperatura_maxima = temperatura_minima + DIFERENCIA_TEMPERATURAS
  end

end
