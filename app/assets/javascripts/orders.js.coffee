window.glg = window.glg or {}
((orders, $) ->
  orders.initSubregions = () ->
    $('#order_billing_country').addClass("form-control")
    $('select#order_billing_country').on "change", (event) ->
      select_wrapper = $('#order_subregion_select_wrapper')

      $('select', select_wrapper).attr('disabled', true)

      billing_country = $(this).val()

      url = "/orders/subregion_options?parent_region=#{billing_country}"
      select_wrapper.load(url)

  orders.errorForm = () ->
    $('#submit-button').addClass('disabled')
    $('#submit-button').attr('disabled','disabled');
    $('input').on "change", (e) ->
      orders.clearErrorForm()
      check = true
      arr = $('input')
      arr.each (i) ->
        content = $(this).val()
        if content == ''
          check = false
          parent = $(this).parent()
          parent.addClass 'has-error'
          parent.children('span').removeClass('hidden')
      if $('#order_billing_country').val() == ""
        $('#order_billing_country').parent().addClass("has-error")
        check = false
      else
        $('#order_billing_country').parent().removeClass("has-error")
          
      if check
        $('#submit-button').removeClass('disabled')
        $('#submit-button').removeAttr('disabled');
        
        

  orders.clearErrorForm = () ->
    $('input').on "change", (event) ->
      parent = $(this).parent()
      parent.removeClass 'has-error'
      parent.children('span').addClass('hidden')
    $('#order_billing_country').on "change", (event) ->
      parent = $(this).parent()
      parent.removeClass 'has-error'

  last_order = null
  orders.showOrder = (order_id) ->
    if last_order != null
      $("#hidden-row-#{last_order}").addClass('hidden')
    if last_order != order_id
      last_order = order_id
      $("#hidden-row-#{last_order}").removeClass('hidden')
    else
      last_order = null
      
) window.glg.orders = window.glg.orders or {}, jQuery