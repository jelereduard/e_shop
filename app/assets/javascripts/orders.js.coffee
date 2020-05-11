$("select#order_billing_country").on "change", ->
  text_code = $(@).find(':selected').text()
  code = $(@).val()
  $(".subregion").prop("disabled", true)
  if text_code == "Please select a country"
    code = text_code
  $.ajax
    url: "/orders/get_country_subregions"
    type: "GET"
    data:
      country: code
    dataType: 'script'


# $ ->
#   $('select#order_billing_country').on "change", (event) ->
#     select_wrapper = $('#order_subregion_select_wrapper')

#     $('select', select_wrapper).attr('disabled', true)

#     billing_country = $(this).val()

#     url = "/orders/subregion_options?parent_region=#{billing_country}"
#     select_wrapper.load(url)


