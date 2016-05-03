
var map;
var big_marker=0;
var x_coords = gon.x;
var y_coords = gon.y;
var img = gon.img;
var albums = gon.albums;
var color = gon.color;
var default_loc ={lat: 37.09, lng:-74.5};
changeWidth(x_coords);
var colors=       [ "amber", "blue_grey", "blue", "brown", "cyan",
                    "deep_orange", "deep_purple", "green", "grey",
                    "indigo", "light_blue", "light_green", "lime",
                    "orange", "pink", "purple", "red", "teal", "yellow"];
var backgrounds =[];

for (var i = 0; i < colors.length; i++) {
  backgrounds.push("../../img/backgrounds/"+colors[i]+".png")
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
    scaledSize: new google.maps.Size(35,35),
    anchor: new google.maps.Point(17.5,17.5)
  };
  var background = {
    url: backgrounds[color[int]],
    scaledSize: new google.maps.Size(40,40),
    anchor: new google.maps.Point(20,20)
  }

  var background =new google.maps.Marker({
    position: LngLnt,
    map:map,
    icon: background,
    zIndex: 0
  });

  var marker= new google.maps.Marker({
    position: LngLnt,
    map:map,
    icon: image,
    zIndex: 1,
    myData: albums[int],
    back: background
  });



  marker.addListener('click', markerClick);
  return LngLnt;
}

function markerClick(int){

  if(big_marker!=0){
    big_marker.setVisible(false);
    big_marker.back.setVisible(false);
    var image={
      url: big_marker.getIcon().url,
      scaledSize: new google.maps.Size(35,35),
      anchor: new google.maps.Point(17.5,17.5)
    };
    var background_image={
      url: big_marker.back.getIcon().url,
      scaledSize: new google.maps.Size(40,40),
      anchor: new google.maps.Point(20,20)
    };
    var background = new google.maps.Marker({
      position: big_marker.getPosition(),
      map: this.getMap(),
      icon: background_image,
      zIndex:0
    });
    var marker= new google.maps.Marker({
      position: big_marker.getPosition(),
      map: this.getMap(),
      icon: image,
      zIndex:1,
      myData: this.myData,
      back: background
    });
    marker.addListener('click', markerClick)
  }

  if(this.getIcon().scaledSize= new google.maps.Size(35,35)){
    this.setVisible(false);
    this.back.setVisible(false);

    var image = {
      url: this.getIcon().url,
      scaledSize: new google.maps.Size(100,100),
      anchor: new google.maps.Point(50,50)
    };

    var background_image={
      url: this.back.getIcon().url,
      scaledSize: new google.maps.Size(110,110),
      anchor: new google.maps.Point(55,55)
    };

    var background= new google.maps.Marker({
      position: this.getPosition(),
      map:this.getMap(),
      icon: background_image,
      zIndex:0
    });

    var marker = new google.maps.Marker({
      position: this.getPosition(),
      map:this.getMap(),
      icon:image,
      zIndex:1,
      myData: this.myData,
      back: background
    });
    big_marker= marker;
    marker.addListener('click', gotoAlbum);
}
else if(this.getIcon().scaledSize= new google.maps.Size(100,100)) {
  gotoAlbum();
}

}

function gotoAlbum(){
  window.location.href = "/albums/"+this.myData;
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
    document.getElementById("map").style.width='60%';
    document.getElementById("map").style.left="2.5%";
  }else{
    document.getElementById("map").style.width='95%';
    document.getElementById("map").style.left="2.5%";
  }
}
