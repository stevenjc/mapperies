function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: parseFloat(40.7), lng:parseFloat(-74)},
    zoom: 4
  })
  map.addListener('idle', function(){
    $("#loader").fadeOut(250);
  });
};
