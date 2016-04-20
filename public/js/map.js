
var map;
var x_coords = gon.x;
var y_coords = gon.y;
var img = gon.img;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat:parseFloat(x_coords[0]), lng:parseFloat(y_coords[0])},
    zoom: 8
  });
  for (i=0;i<img.length;i++){
    addMarker(i, map);
  }

}
function addMarker(int, map){
  var LngLnt = {lat: parseFloat(x_coords[int]), lng: parseFloat(y_coords[int])};

  var image = {
    url: img[int],
    scaledSize: new google.maps.Size(25,25)
  //  origin: new google.maps.Point(0,0)
  }

  var marker= new google.maps.Marker({
    position: LngLnt,
    map:map,
    icon: image,
    zIndex: 1
  });
//  marker.addListener('click', markerClick);
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
  window.location.href = "/albums";
}
