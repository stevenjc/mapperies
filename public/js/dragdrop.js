var unmapped = document.getElementsByClassName("unmapped_photo");
var input = document.getElementById("dragphoto");

for (var i=0;i<unmapped.length;i++){
  unmapped[i].addEventListener('mousedown', myFunction);
};

function myFunction(){
  input.value = this.id;
};
