$(document).ready(function(){

  $("#start").click(function(event){
    event.preventDefault();
    if ($('#pick_genres').length == 0) {
      $.get('/pick_genres', function(response){
        $('body').append(response);
        
        $('body').animate({
          scrollTop: $("div.genre_select").offset().top - 200
        }, 300);

      });
    }
  }); 

});
