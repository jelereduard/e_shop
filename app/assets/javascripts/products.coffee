checkServerResp = (url, data) ->
  $.ajax
    url: url
    type: "POST"
    data: data 
    dataType: "json"

$("#add-to-cart").on "click",(e) ->
  e.preventDefault
  url = $(@).attr("data-url")
  data={}
  data['product_id']=$(@).attr("data-id")
  debugger
  checkServerResp(url, data)
