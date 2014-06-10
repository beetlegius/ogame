module ApplicationHelper
	CLASES = { alert: :danger, notice: :success, info: :info }

  def bootstrap_flash
    flash.map do |key, mensaje|
      content_tag :div, mensaje, class: ["alert", "alert-block", "alert-#{CLASES[key.to_sym]}"]
    end.join.html_safe
  end

  def tiempo(elemento)
    segundos = elemento.tiempo_restante
  	content_tag :time, ChronicDuration.output(segundos, format: :short), datetime: "+#{segundos.to_i}s", data: { countdown: true } if segundos
  end

  def fecha(una_fecha, opciones = {})
    una_fecha.present? ? l(una_fecha, opciones) : "-"
  end

end
