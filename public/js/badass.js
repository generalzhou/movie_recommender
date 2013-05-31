$(document).ready(function(){

    $("#start").click(function(event){
    event.preventDefault();
    if ($('#pick_genres').length == 0) {
      $.get('/pick_genres', function(response) {
        $('body').append(response);
        $('body').scrollTop(600);
        });
      }
    }); 

    $("#start").click(function(event){
    event.preventDefault();
    if ($('#pick_movies').length == 0) {
      $.get('/pick_genres', function(response) {
        $('body').append(response);
        $('body').scrollTop(600);
        });
      }
    }); 

});
