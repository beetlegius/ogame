#= require jquery2
#= require jquery_ujs
#= require jquery.turbolinks
#= require turbolinks
#= require jquery.countdown
#= require jquery.countdown-es
#= require_self

ready = ->
  tamano = $(window).innerHeight() - $("#header_top").height() - 40

  $("#content").css('height', tamano)

  $.each $("[data-countdown]"), (i, elemento) ->
  	$(elemento).countdown({ until: $(elemento).attr('datetime'), compact: true, onTick: monitorear_countdown })

  $("form.seleccionar").on 'change', ->
  	$(this).submit()

  $('a.set-fabricacion').on 'click', ->
    cantidad = $(this).data("cantidad")
    target = $(this).data("target")
    input = $(target).val(cantidad)


monitorear_countdown = (periodo) ->
	cuenta = $.grep periodo, (elemento, i) ->
		elemento != 0

	if $.isEmptyObject(cuenta)
		setTimeout ->
	  	location.reload()
	  , 5000

$ ->
  ready()
