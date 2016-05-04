/*
  Map.js
    This file is used to generate the map on which the users photos are marked
    as well as the ability to add new photos to the map by clicking on an
    unmapped photo and then clicking on the map in a position

    Author: Ted McNulty
*/


changeWidth();          //Modify the width of the image based on if there are unmapped photos
makeLegend(gon.albums); //Create check boxes for each album in the map

//Declare variables we will use

var map;                //Map variable
var big_marker=0;       //ID of the marker most recently clicked on
var x_coords = gon.x;   //X coordinates for all the photos ready to be mapped
var y_coords = gon.y;   //Y coordinates for all the photos ready to be mapped
var img = gon.img;      //URL links for all the photos ready to be mapped
var albums = gon.albums;//Array which stores which album each image was in
var color = gon.color;  //
var default_loc = {lat: 37.09, lng:-74.5};  //keep a default location in case there are no images
var backgrounds =[];    //URL links to the background images to organize photos by album
var markers=[];         //references to the markers on the map

//All the possible color backgrounds to organize the photos by album
var colors=       [ "amber", "blue_grey", "blue", "brown", "cyan",
                    "deep_orange", "deep_purple", "green", "grey",
                    "indigo", "light_blue", "light_green", "lime",
                    "orange", "pink", "purple", "red", "teal", "yellow"];

//Populate backgrounds with all the URLs
for (var i = 0; i < colors.length; i++) {
  backgrounds.push("../../img/backgrounds/"+colors[i]+".png")
};

//Allow the pre-loader to be visible on pages with maps
$("#loader").hidden=false;

//Create and initialize the map
function initMap() {
  //Give the map some default values for error checking
  map = new google.maps.Map(document.getElementById('map'), {
    center: default_loc,
    zoom: 5
  });

  //Create the bounds variable which will help set the zoom/center of the map
  var bounds = new google.maps.LatLngBounds();

  //Add an event listener to the map to add picture when you drag a photo onto it
  map.addListener('click', function(e){

    //Grab form info from inside the iFrame
    var content = iframeRef(document.getElementById("ifrm")); //Iframe
    var input = content.getElementById("dragphoto");          //photo_id
    var album = content.getElementById("album_id");           //album_id

    //Grab the photo_id of the image we are about to map
    var id =input.value;

    //If the user has selected a photo to give coordinates
    if(id>0){

      //Grab the location where the user clicked on the map and parse to get coordinates
      var loc = e.latLng.toString();
      loc = loc.substring(1, loc.length-1);
      loc = loc.split(",");
      var latLng = {lat: parseFloat(loc[0]), lng: parseFloat(loc[1])};

      //If both the photo_id and album_id exist create the marker
      if(id!="" && album.value!="null"){

        //Grab which photo the user clicked on
        var picture = document.getElementById(id);

        //Create an icon for what the marker will look like
        var icon = {
          url: picture.src,                         //marker should be the image user clicked on
          scaledSize: new google.maps.Size(35,35),  //It starts off as 35x35px
          anchor: new google.maps.Point(17.5,17.5)  //The image should be centered around the coordinates
        };

        //Create another icon to have a boarder to the image
        var background_image={
          url: backgrounds[album.value],            //The color depends on what album its from
          scaledSize: new google.maps.Size(40,40),  //The boarder is a bit bigger than the image
          anchor: new google.maps.Point(20,20)      //Again, the image should centered around the coordinates
        };

        //Actually create the marker
        var marker = new google.maps.Marker({
          position: latLng,                       //Give it coordinates
          map: this,                              //It should be on the only map we have
          icon: icon,                             //The marker should be the image we made earlier
          zIndex: 1,                              //The marker should be above the border
          animation: google.maps.Animation.DROP   //Make the image fall into position
        });

        //Make the border after 1 second
        setTimeout(makeMarker(latLng, this, background_image), 1000);
      }

      //Fill in the form with the coordinates where the user cliced
      var content = iframeRef(document.getElementById("ifrm"));
      var x = content.getElementById("x").value=loc[0];
      var y = content.getElementById("y").value=loc[1];

      //Remove the photo we are about to map from the "unmapped" div
      document.getElementById(id).hidden=true;

      //Submit the form to map the photo and save to database
      content.getElementById("submit").click();
  }
  });

  //Add an event listener which will fade out the pre-loader when the map is ready
  map.addListener('idle', function(){
    $("#loader").fadeOut(250);
  });

  //Add all the photos to the map, and add them to the bounds for zoom/center
  for (i=0;i<img.length;i++){
    bounds.extend(addMarker(i, map));
  };

  //Once all the photos are mapped, change the zoom/center of the map
  if(img.length>0){
    map.fitBounds(bounds);
  };
};


function addMarker(int, map){
  //Grab the coordinates from the x_coords and y_coords arrays
  var LngLnt = new google.maps.LatLng(parseFloat(x_coords[int]), parseFloat(y_coords[int]));


  var image = {
    url: img[int],  //The image will be the nth image in the array passed to JS
    scaledSize: new google.maps.Size(35,35),
    anchor: new google.maps.Point(17.5,17.5)
  };

  var background = {
    url: backgrounds[color[int]], //The background color will be nth color from the Array
    scaledSize: new google.maps.Size(40,40),
    anchor: new google.maps.Point(20,20)
  };



  //Create the border
  var background =new google.maps.Marker({
    position: LngLnt,
    map:map,
    icon: background,
    zIndex: 0       //Make sure its behind the real image
  });

  //Create the marker
  var marker= new google.maps.Marker({
    position: LngLnt, //Give it the coordinates from the DB
    map:map,          //put it on the map
    icon: image,      //make it look like the image we specified
    zIndex: 1,        //Make sure its above the border
    myData: albums[int], //Save into the marker which album it is from
    back: background,    //Save into the marker which border should be used
    animation: google.maps.Animation.DROP //Let the marker fall into place
  });

  //Allow the marker to be clicked on
  marker.addListener('click', markerClick);
  //return the coordinates to be added to the bounds
  return LngLnt;
}

//When a user clicks on a photo it will be enlargened, if it is already large
//the user will be redirected to the album page for that photo
function markerClick(int){

  //If the user has clicked on a marker previously, make the old one small again
  if(big_marker!=0){

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
    big_marker.setIcon(image);
    big_marker.back.setIcon(background_image);
  }

  //If the photo clicked on is small still make it large
  if(this!=big_marker){
    alert("!!!!");
    var image = {
      url: this.getIcon().url,    //Keep the same image
      scaledSize: new google.maps.Size(100,100),  //But make it much larger
      anchor: new google.maps.Point(50,50)
    };

    var background_image={
      url: this.back.getIcon().url, //Keep the same border color
      scaledSize: new google.maps.Size(110,110),  //But make it much larger
      anchor: new google.maps.Point(55,55)
    };

    this.setIcon(image);
    this.back.setIcon(background_image);
    //Set the marker we just clicked on as the most recently clicked marker
    big_marker= this;
  }
  else{
    window.location.href= "/albums/"+this.myData;
  }
}

function goToAlbum(){
  window.location.href= "/albums/"+this.myData;
}

//Function to change the width of the map based on if there are unmapped photos
function changeWidth(){
  if(gon.unmapped.length>0){
    document.getElementById("map").style.width='60%';
    document.getElementById("map").style.left="2.5%";
  }else{
    document.getElementById("map").style.width='95%';
    document.getElementById("map").style.left="2.5%";
  }
}

//Function to add the marker with the help of setTimeout()
function makeMarker(latLng, map, background_image){
  new google.maps.Marker({
    position: latLng,
    map: map,
    icon: background_image,
    zIndex:0,
    animation: google.maps.Animation.DROP
  });
}

function makeLegend(albums){
  var album_list = document.getElementById("album_list");
  var distinct=[];
  for (var i = 0; i < albums.length; i++) {
    // album_list.appendChild(document.createElement('input'))
    if(!distinct.includes(albums[i])){
      distinct.push(albums[i]);
    }
  }
  alert(distinct);
}
