
var map;
var coords = gon.brandeisCoords;
var brandeis = gon.brandeis;
var brandeisCoords = {lat:42.3657, lng:-71.2597};

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat:42.3657, lng:-71.2597},
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
    scaledSize: new google.maps.Size(25,25)
  //  origin: new google.maps.Point(0,0)
  }

  var marker= new google.maps.Marker({
    position: LngLnt,
    map:map,
    icon: image,
    zIndex: 1
  });
  marker.addListener('click', markerClick);
}

function markerClick(){
  if(this.getIcon().scaledSize= new google.maps.Size(25,25)){
    this.setVisible(false);
    var image = {
      url: this.getIcon().url,
      scaledSize: new google.maps.Size(75,75)
    }
    var marker = new google.maps.Marker({
      position: this.getPosition(),
      map:this.getMap(),
      icon:image,
      zIndex:1
    })
    marker.addListener('click', gotoAlbum);

}else if(this.getIcon().scaledSize= new google.maps.Size(75,75)) {
  gotoAlbum();
}
}

function gotoAlbum(){
  window.location.href = "main/albums";
}
