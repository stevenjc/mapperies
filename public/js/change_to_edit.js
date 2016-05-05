function edit(restricted){
  if(! restricted){
    // Grab the album name field, its parent tag and create an input value
    // var parent = document.getElementById("album_name_parent");  //div which hold the name field
    // var button = document.getElementById("edit_name");
    if (document.getElementById("change_notice")){
      document.getElementById("change_notice").innerHTML= "";
    }
    var field = document.getElementById("album_name");
    var name = document.getElementById("album_name").innerHTML;
    //Check that name field isn't already editing
    if(field.class != "editing"){
      field.class="editing";  //Mark field as editing
      //Replace Name with input field
      document.getElementById("album_name").innerHTML = '<input type="text" id="input_name" placeholder="'+ field.innerHTML+'">';
      var new_name = document.getElementById("input_name");
      //User cursor moved into input field and submission occurs when enter key is hit
      $("input").focus();
      $("input").keyup(function(e){
        if (e.which == 13) {
          if (new_name.value==""){
            document.getElementById("album_name").innerHTML= name;
            field.class="";
          }else {
            field.class="";
            document.getElementById("album_name").innerHTML= new_name.value;
            var content = iframeRef(document.getElementById("ifrm"));

            var n= content.getElementById("a_name");
          //  var name = document.createElement("P");
            var submit = content.getElementById("submit_album_name_edit");
            name.id="album_name";
            var input = new_name.value;

            name.innerHTML=input;
            n.value=input;

            submit.click();
            //NEED TO DO ACTUAL INPUT SUBMISSION
          }
        }
      });
    }
  }
}

function iframeRef( frameRef ) {
    return frameRef.contentWindow
        ? frameRef.contentWindow.document
        : frameRef.contentDocument
}
