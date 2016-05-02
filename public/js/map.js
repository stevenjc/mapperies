
var map;
var x_coords = gon.x;
var y_coords = gon.y;
var img = gon.img;
var albums = gon.albums;
var default_loc ={lat: 37.09, lng:-74.5};
changeWidth(x_coords);
var colors=       [ "amber", "blue_grey", "blue", "brown", "cyan",
                    "deep_orange", "deep_purple", "green", "grey",
                    "indigo", "light_blue", "light_green", "lime",
                    "orange", "pink", "purple", "red", "teal", "yellow"];
var backgrounds =[];

for (var i = 0; i < colors.length; i++) {
  backgrounds.push("../img/backgrounds/"+colors[i]+".png")
};

function initMap() {
  //Make the map
  map = new google.maps.Map(document.getElementById('map'), {
    center: default_loc,
    zoom: 5
  });
  var bounds = new google.maps.LatLngBounds();

  // alert(bounds.toString());

  //Add an event listener to the map to add picture when you drag a photo onto it
  map.addListener('click', function(e){

    //Grab form info from inside the iFrame
    var content = iframeRef(document.getElementById("ifrm"));
    var input = content.getElementById("dragphoto");

    var id =input.value;
    if(id>0){
      var loc = e.latLng.toString();
      loc = loc.substring(1, loc.length-1);
      loc = loc.split(",");
      if(id!=""){
        var picture = document.getElementById(id);
        var icon = {
          url: picture.src,
          scaledSize: new google.maps.Size(35,35)
        }
        var marker = new google.maps.Marker({
          position: {lat: parseFloat(loc[0]), lng: parseFloat(loc[1])},
          map: this,
          icon: icon,
          zIndex: 1
        })
      }
      var content = iframeRef(document.getElementById("ifrm"));
      var x = content.getElementById("x");
      var y = content.getElementById("y");

      document.getElementById(id).hidden=true;

      x.value=loc[0];
      y.value=loc[1];

      content.getElementById("submit").click();
  }
  });

  //Add all the current photos
  for (i=0;i<img.length;i++){
    bounds.extend(addMarker(i, map));
  };

  if(img.length>0){
    map.fitBounds(bounds);
  };
};


function addMarker(int, map){
  // var LngLnt = {lat: parseFloat(x_coords[int]), lng: parseFloat(y_coords[int])};
  var LngLnt = new google.maps.LatLng(parseFloat(x_coords[int]), parseFloat(y_coords[int]));

  var image = {
    url: img[int],
    scaledSize: new google.maps.Size(35,35)
  //  origin: new google.maps.Point(0,0)
  };

  var marker= new google.maps.Marker({
    position: LngLnt,
    map:map,
    icon: image,
    zIndex: 1
  });
  // alert(LngLnt.toString());
  marker.addListener('click', markerClick);
  return LngLnt;
}

function markerClick(){
  if(this.getIcon().scaledSize= new google.maps.Size(35,35)){
    this.setVisible(false);
    var image = {
      url: this.getIcon().url,
      scaledSize: new google.maps.Size(100,100)
    }
    var marker = new google.maps.Marker({
      position: this.getPosition(),
      map:this.getMap(),
      icon:image,
      zIndex:1
    })
    marker.addListener('click', gotoAlbum);

}else if(this.getIcon().scaledSize= new google.maps.Size(100,100)) {
  gotoAlbum();
}
}

function gotoAlbum(){
  window.location.href = "/albums";
}
function mean(x){
  var result=0;
  for (var i = 0; i < x.length; i++) {
    result+=x[i];
  }
  return result/x.length;
}
function changeWidth(x){
  if(gon.unmapped.length>0){
    document.getElementById("map").style.width='65%';
    alert("65");
  }else{
    document.getElementById("map").style.width='100%';
    alert("100");
  }
}
