module Excepciones
	module Nivelable
		class FalloExpansion < StandardError

	    def initialize(expandible)
	      @expandible = expandible
	    end

	    def to_s
	      I18n.t("errors.messages.fallo_expansion", expandible: @expandible)
	    end

	  end
	end
end