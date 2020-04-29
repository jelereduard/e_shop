checkServerResp = (url, data) ->
  $.ajax
    url: url
    type: "POST"
    data: data
    dataType: "json"

$("#add-to-cart").on "click",(e) ->
  data={}
  url = $(@).attr(“data-url”)
  checkServerResp(url, data).done

  .fail
    