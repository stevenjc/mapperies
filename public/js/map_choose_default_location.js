
var map;
var brandeisCoords = {lat:42.3657, lng:-71.2597};
var default_marker = "../img/marker_blue.png";
var new_marker = "../img/marker_green.png";

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat:42.3657, lng:-71.2597},
    zoom: 4
  });

  var default_loc =  new google.maps.Marker({
    position: brandeisCoords,
    map:map,
    icon:default_marker
  })
  var new_loc = new google.maps.Marker({
    position:brandeisCoords,
    map:map,
    icon:new_marker
  })

  map.addListener('click', function(e){
  //  alert(e.latLng);
    new_loc.setPosition(e.latLng);
  })


}

function placeMarker(position, map){
  var marker = new google.maps.Marker({
    position: position,
    map:map
  });
}
