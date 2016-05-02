var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: parseFloat(40.7), lng:parseFloat(-74)},
    zoom: 4
  })};

parent.window.onload= function() {
  var default_marker = "../img/marker_blue.png";
  var new_marker = "../img/marker_green.png";

  var content = iframeRef(document.getElementById("ifrm"));
  var xcoord = content.getElementById("xcoord");
  var ycoord = content.getElementById("ycoord");
  var submit = content.getElementById("submit_album_name_edit");
  var dcoord={lat: parseFloat(40.7), lng:parseFloat(-74)};
  if (xcoord.value==0){
    dcoord = {lat: parseFloat(40.7), lng:parseFloat(-74)};
  }else{
    dcoord = {lat: parseFloat(xcoord.value), lng: parseFloat(ycoord.value)};
  }



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

    new_loc.addListener('click', function(){
      submit.click();
      default_loc.setPosition(new_loc.getPosition())
    })

    map.addListener('click', function(e){
      //alert(e.latLng);
      var loc = e.latLng.toString();
      new_loc.setPosition(e.latLng);
      loc = loc.substring(1, loc.length-1);
      loc = loc.split(",");
      xcoord.value= loc[0];
      ycoord.value= loc[1];
    });




  function placeMarker(position, map){
    var marker = new google.maps.Marker({
      position: position,
      map:map
    });
  }
}
