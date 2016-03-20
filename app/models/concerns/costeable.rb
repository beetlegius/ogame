module Costeable
  extend ActiveSupport::Concern

  module ClassMethods

    attr_accessor :costo_metal_base, :costo_cristal_base, :costo_deuterio_base, :costo_energia_base

    def establecer_costos(*args)
      atributos = args.extract_options!
      @costo_metal_base    = atributos[:metal]    || 0
      @costo_cristal_base  = atributos[:cristal]  || 0
      @costo_deuterio_base = atributos[:deuterio] || 0
      @costo_energia_base  = atributos[:energia]  || 0
    end

    def factor(numero = 2)
      @factor ||= numero
    end

  end

  def puede_costearse?(expandible)
    expandible.puede_pagar? metal, cristal, deuterio, energia
  end

  def metal    ;     Metal.new     propietario: self  ; end
  def cristal  ;     Cristal.new   propietario: self  ; end
  def deuterio ;     Deuterio.new  propietario: self  ; end
  def energia  ;     Energia.new   propietario: self  ; end

end
