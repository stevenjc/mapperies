$(document).ready(function(){
  var unmapped = document.getElementsByClassName("unmapped_photo");


  for (var i=0;i<unmapped.length;i++){
    unmapped[i].addEventListener('mousedown', fillForm);
  };
});

function fillForm(){
  var content = iframeRef(document.getElementById("ifrm"));
  var inp = content.getElementById("dragphoto");
  inp.value = this.id;
  content.getElementById("album_id").value=this.dataset.album;
};

function iframeRef( frameRef ) {
    return frameRef.contentWindow
        ? frameRef.contentWindow.document
        : frameRef.contentDocument
}
