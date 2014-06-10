module Excepciones
	module Nivelable
		class FalloCancelacion < StandardError

	    def initialize(expandible)
	      @expandible = expandible
	    end

	    def to_s
	      I18n.t("errors.messages.fallo_cancelacion", expandible: @expandible)
	    end

	  end
	end
end