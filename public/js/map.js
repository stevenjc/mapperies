
var map;
var coords = gon.brandeisCoords;
var brandeis = {lat:42.3657, lng:-71.2597};
alert(brandeis);
alert(coords);
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: brandeis,
    zoom: 17
  });
  for (c in coords){
    alert(coords[c]);
  //alert(brandeis);
    var marker = new google.maps.Marker({
      position: Object(coords[c]),
      map: map,
      title: "h5+89587ello"
    })
  }

}
