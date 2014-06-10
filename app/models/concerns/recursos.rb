module Recursos
  extend ActiveSupport::Concern

  def pagar!(metal, cristal, deuterio)
    actualizar_recursos!
    raise unless puede_pagar? metal, cristal, deuterio, nil
    atributos = {
      cantidad_metal: cantidad_metal - metal.costo,
      cantidad_cristal: cantidad_cristal - cristal.costo,
      cantidad_deuterio: cantidad_deuterio - deuterio.costo
    }
    update! atributos
  end

  def devolver!(metal, cristal, deuterio)
    actualizar_recursos!
    atributos = {
      cantidad_metal: cantidad_metal + metal.costo,
      cantidad_cristal: cantidad_cristal + cristal.costo,
      cantidad_deuterio: cantidad_deuterio + deuterio.costo
    }
    update! atributos
  end

  def actualizar_recursos!
    increment :cantidad_metal, produccion_metal + mina_metal.produccion
    increment :cantidad_cristal, produccion_cristal + mina_cristal.produccion
    increment :cantidad_deuterio, produccion_deuterio + mina_deuterio.produccion
    self.ultima_actualizacion_recursos = Time.now
    save!
  end

  # :reek:LongParameterList: { max_params: 4 }
  def puede_pagar?(metal, cristal, deuterio, energia)
    recurso_metal >= metal.try(:costo).to_f && recurso_cristal >= cristal.try(:costo).to_f && recurso_deuterio >= deuterio.try(:costo).to_f && recurso_energia >= energia.try(:costo).to_f
  end

  def recurso_metal
    @recurso_metal ||= (cantidad_metal + produccion_metal + mina_metal.produccion).round
  end

  def recurso_cristal
    @recurso_cristal ||= (cantidad_cristal + produccion_cristal + mina_cristal.produccion).round
  end

  def recurso_deuterio
    @recurso_deuterio ||= (cantidad_deuterio + produccion_deuterio + mina_deuterio.produccion).round
  end

  def recurso_energia
    @recurso_energia ||= (produccion_energia + planta_energia.produccion).round # en un futuro incluirá la energía generada por satélites solares
  end

  def recurso_energia_consumida
    mina_metal.consumo_energia + mina_cristal.consumo_energia + mina_deuterio.consumo_energia
  end

  def recurso_energia_disponible
    @recurso_energia_disponible ||= (recurso_energia - recurso_energia_consumida).round
  end

  def energia_negativa?
    recurso_energia_disponible < 0
  end

  def produccion_metal
    produccion_metal_base.to_f / 3600 * (Time.now - ultima_actualizacion_recursos).round
  end

  def produccion_cristal
    produccion_cristal_base.to_f / 3600 * (Time.now - ultima_actualizacion_recursos).round
  end

  def produccion_deuterio
    produccion_deuterio_base.to_f / 3600 * (Time.now - ultima_actualizacion_recursos).round
  end

  def produccion_energia
    produccion_energia_base.to_f / 3600
  end

  def produccion_metal_base
    20
  end

  def produccion_cristal_base
    10
  end

  def produccion_deuterio_base
    0
  end

  def produccion_energia_base
    0
  end

end
