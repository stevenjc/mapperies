
var map;
var brandeisCoords = {lat:42.3657, lng:-71.2597};
var marker;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat:42.3657, lng:-71.2597},
    zoom: 16
  });

  var default_loc =  new google.maps.Marker({
    position: brandeisCoords,
    map:map
  })

  map.addListener('click', function(){
    marker = new google.maps.Marker({
      position: mouse.getPosition(),
      map:map
    })
  })


}

function placeMarker(position, map){
  var marker = google.maps.Marker({
    position: position,
    map:map
  });
}
