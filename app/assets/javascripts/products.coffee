$(document).ready -> 
  $(".add-to-cart").on "click",(e) ->
    url = $(@).attr("data-url")
    data={}
    data['product_id']=$(@).attr("data-id")
    $.ajax
      url: url
      type: "POST"
      data: data 
      dataType: "json"
      success: (result) ->
        if result.status=="success"
          total_items=parseInt($("#cart_item").text())
          total_items+=1
          $("#cart_item").text(total_items)
        else
          if result.product_id? && result.status=="failed"
            product_button="a[data-id="+result.product_id+"]"
            $(product_button).attr("disabled",true).addClass("disabled")
            product_text='a[href="products/'+result.product_id+'"]'
            $(product_text).find("div").find("p.out-of-stock").removeClass("hidden")
  $('#form-filter-products').on 'keypress', (event) ->
    if event.keyCode == 13
      query = $(this).val()
      $.ajax(
        url: '/products',
        type: 'GET',
        data: { qtitle: query }
    )