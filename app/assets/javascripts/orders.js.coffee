$.initSubregions = () ->
  $('#order_billing_country').addClass("form-control")
  $('select#order_billing_country').on "change", (event) ->
    select_wrapper = $('#order_subregion_select_wrapper')

    $('select', select_wrapper).attr('disabled', true)

    billing_country = $(this).val()

    url = "/orders/subregion_options?parent_region=#{billing_country}"
    select_wrapper.load(url)

