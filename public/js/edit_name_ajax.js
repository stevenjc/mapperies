
$(document).ready(function(){
  alert("G");
  $("#xx").click(function(){
    alert("DSF");
    $.ajax({
      type:"PATCH",
      url: "/album/23",
      data:{},
      success:(data) ->
        alert data.id
        return false
      error:(data) ->
        return false
    })
  })
})
