$(document).ready(function(){
  var unmapped = document.getElementsByClassName("photo");

  for (var i=0;i<unmapped.length;i++){
    unmapped[i].addEventListener('mousedown', function(){
      document.getElementById("avatar_id").value=this.id;
    });
  };
});

function fillForm(){
  var inp =document.getElementById("avatar_id");
  inp.value="!!!!";
};
