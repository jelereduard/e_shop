$(document).ready -> 
  checkServerResp = (url, data) ->

  $(".add-to-cart").on "click",(e) ->
    e.preventDefault
    url = $(@).attr("data-url")
    data={}
    data['product_id']=$(@).attr("data-id")
    $.ajax
      url: url
      type: "POST"
      data: data 
      dataType: "json"
      success: (result) ->