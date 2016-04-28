function edit(){
  // Grab the album name field, its parent tag and create an input value
  var parent = document.getElementById("album_name_parent");  //div which hold the name field
  var button = document.getElementById("edit_name");


  //Change the buttons to allow user to type where album name was
  if(button.innerHTML=="Edit"){
    var name = document.getElementById("album_name");
    var input = document.createElement("input");

    // Make the new input value a text input
    input.type="text";
    input.value = name.innerHTML;
    input.id = "input_name";

    // Print the value in the box for texting
    // alert(name.innerHTML);

    // Remove all the children in the form
    while (parent.hasChildNodes()){
      parent.removeChild(parent.firstChild);
    }
    // Add in the new text field
    parent.appendChild(input, parent.childNodes[0]);
    button.innerHTML="Submit";

  }
  //Change the buttons back to normal and submit the form to update the
  //name in the database
  else if (button.innerHTML=="Submit") {
    var n= document.getElementById("a_name");
    var name = document.createElement("P");
    var submit = document.getElementById("submit_album_name_edit");
    name.id="album_name";
    var input = document.getElementById("input_name");

    name.innerHTML=input.value;
    n.value=input.value;

    while (parent.hasChildNodes()){
      parent.removeChild(parent.firstChild);
    }

    parent.appendChild(name, parent.childNodes[0]);

    button.innerHTML="Edit";
    submit.click();
  }
}
