module Recursos
  extend ActiveSupport::Concern

  def pagar!(metal, cristal, deuterio, cantidad = 1)
    actualizar_recursos!
    raise unless puede_pagar? metal, cristal, deuterio, nil, cantidad
    atributos = {
      cantidad_metal: cantidad_metal - metal.costo * cantidad,
      cantidad_cristal: cantidad_cristal - cristal.costo * cantidad,
      cantidad_deuterio: cantidad_deuterio - deuterio.costo * cantidad
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
    increment :cantidad_deuterio, produccion_deuterio + mina_deuterio.produccion - consumo_deuterio_planta_fusion
    self.ultima_actualizacion_recursos = Time.now
    save!
  end

  # :reek:LongParameterList: { max_params: 4 }
  def puede_pagar?(metal, cristal, deuterio, energia, cantidad = 1)
    recurso_metal >= cantidad * metal.try(:costo).to_f && recurso_cristal >= cantidad * cristal.try(:costo).to_f && recurso_deuterio >= cantidad * deuterio.try(:costo).to_f && recurso_energia >= energia.try(:costo).to_f
  end

  def recurso_metal
    @recurso_metal ||= (cantidad_metal + produccion_metal + mina_metal.produccion).round
  end

  def recurso_cristal
    @recurso_cristal ||= (cantidad_cristal + produccion_cristal + mina_cristal.produccion).round
  end

  def recurso_deuterio
    @recurso_deuterio ||= (cantidad_deuterio + produccion_deuterio + mina_deuterio.produccion - consumo_deuterio_planta_fusion).round
  end

  def recurso_energia
    @recurso_energia ||= (produccion_energia + planta_energia.produccion + planta_fusion.produccion + satelite_solar.produccion).floor
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

  def consumo_deuterio_planta_fusion
    planta_fusion.consumo_deuterio_hora.to_f / 3600 * (Time.now - ultima_actualizacion_recursos).round
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
