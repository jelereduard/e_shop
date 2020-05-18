$.initSubregions = () ->
  $('#order_billing_country').addClass("form-control")
  $('select#order_billing_country').on "change", (event) ->
    select_wrapper = $('#order_subregion_select_wrapper')

    $('select', select_wrapper).attr('disabled', true)

    billing_country = $(this).val()

    url = "/orders/subregion_options?parent_region=#{billing_country}"
    select_wrapper.load(url)

$.errorForm = () ->
  console.log()
  check = true
  arr = $('input')
  
  arr.each (i) ->
    content = $(this).val()
    if content == ''
      check = false
      console.log $(this)
      $(this).parent().addClass 'has-error'
  return check

last_order = null
$.showOrder = (order_id) ->
  if last_order != null
    $("#hidden-row-#{last_order}").addClass('hidden')
  if last_order != order_id
    last_order = order_id
    $("#hidden-row-#{last_order}").removeClass('hidden')
  else
    last_order = null