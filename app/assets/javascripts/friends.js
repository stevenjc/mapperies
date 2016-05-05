$(function(){
  //hide or collapsed initially.
  $('#services').find('ul').hide();
  $('#services').find("span.expand").click(function(e){
      $(this).parent().children('ul').toggle();
  });
});


function remove_friend(){
  if (confirm('Are you sure?')) {
       window.location.reload();
  }
}   

$(document).ready(function(){
  $('.friend-album-list').slick({
    lazyLoad: 'ondemand',
    dots: false,
    arrows: false,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    slidesToScroll: 2,
    centerMode: true,
    adaptiveHeight: false,
    responsive: [
      {
        breakpoint: 1024,
        settings: {
          slidesToShow: 3,
          slidesToScroll: 1,
          infinite: true,
        }
      },
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
          infinite: true,
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
          infinite: true,
        }
      }
    ]
  });
});
