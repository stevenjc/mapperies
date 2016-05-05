function edit(){
  // Grab the album name field, its parent tag and create an input value
  var parent = document.getElementById("album_name_parent");  //div which hold the name field
  var button = document.getElementById("edit_name");

  var field = document.getElementById("album_name");
  var name = document.getElementById("album_name").innerHTML;
  //Change the buttons to allow user to type where album name was
  if(field.class != "editing"){
    field.class="editing";
    document.getElementById("album_name").innerHTML = '<input type="text" id="input_name" placeholder="'+ field.innerHTML+'">';
    var new_name = document.getElementById("input_name");
    $("input").focus();
    $("input").keyup(function(e){
      if (e.which == 13) {
        if (new_name.value==""){
          document.getElementById("album_name").innerHTML= name
        }else {
          document.getElementById("album_name").innerHTML= new_name.value
        }
        field.class="";
        //NEED TO DO ACTUAL INPUT SUBMISSION
      }
    });
  }
}
  //}
  //Change the buttons back to normal and submit the form to update the
  //name in the database
  // else if (button.innerHTML=="Submit") {
  //   var content = iframeRef(document.getElementById("ifrm"));
  //
  //   var n= content.getElementById("a_name");
  //   var name = document.createElement("P");   //!!!!!!!!!!!!!!!!
  //   var submit = content.getElementById("submit_album_name_edit");
  //   name.id="album_name";
  //   var input = document.getElementById("input_name");
  //
  //   name.innerHTML=input.value;
  //   n.value=input.value;
  //
  //   while (parent.hasChildNodes()){
  //     parent.removeChild(parent.firstChild);
  //   }
  //
  //   parent.appendChild(name, parent.childNodes[0]);
  //
  //   button.innerHTML="Edit";
  //   submit.click();
  // }
