
var map;
var brandeisCoords = {lat:42.3657, lng:-71.2597};
var default_marker = "../img/marker_blue.png";
var new_marker = "../img/marker_green.png";
var xcoord = document.getElementById("xcoord");
var ycoord = document.getElementById("ycoord");
var dcoord;
if (xcoord.value==0){
  dcoord = {lat: parseFloat(40.7), lng:parseFloat(-74)};
}else{
  dcoord = {lat: parseFloat(xcoord.value), lng: parseFloat(ycoord.value)};
}

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: dcoord,
    zoom: 4
  });

  var default_loc =  new google.maps.Marker({
    position: dcoord,
    map:map,
    icon:default_marker
  });
  var new_loc = new google.maps.Marker({
    position:dcoord,
    map:map,
    icon:new_marker
  });

  map.addListener('click', function(e){
    //alert(e.latLng);
    var loc = e.latLng.toString();
    new_loc.setPosition(e.latLng);
    loc = loc.substring(1, loc.length-1);
    loc = loc.split(",");
    xcoord.value= loc[0];
    ycoord.value= loc[1];
  });


}

function placeMarker(position, map){
  var marker = new google.maps.Marker({
    position: position,
    map:map
  });
}
