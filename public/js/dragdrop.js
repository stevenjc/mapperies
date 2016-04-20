var unmapped = document.getElementsByClassName("unmapped_photo");

for (var i=0;i<unmapped.length;i++){
  unmapped[i].addEventListener('mousedown', myFunction(), false);
};

 function myFunction(){
  alert("Hello!");
};
