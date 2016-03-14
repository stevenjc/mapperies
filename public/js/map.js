
var map;
var coords = gon.brandeisCoords;
var brandeis = gon.brandeis;
var brandeisCoords = {lat:42.3657, lng:-71.2597};

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: brandeisCoords,
    zoom: 16
  });
  for (i=0;i<coords.length;i++){
    addMarker(i, map);
  }

}
function addMarker(int, map){
  var LngLnt = {lat:brandeis[int].x_coord, lng:brandeis[int].y_coord};

  var image = {
    url: brandeis[int].url,
    size: new google.maps.Size(25,25)
  //  origin: new google.maps.Point(0,0)
  }

  var marker= new google.maps.Marker({
    position: LngLnt,
    map:map,
    icon: image
  })
}
