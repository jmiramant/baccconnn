$(document).ready(function() {
  
  $("button").on('click', function(e){
    e.preventDefault();

    var baconString;

    var getBacon = $.getJSON('https://baconipsum.com/api/?callback=?', 
      { 'type':'all-meat', 'sentences':'1' }).done(function(baconGoodness){
        var baconString = baconGoodness[0];
        var url = $('form .url').val();
        $.ajax({
          type: "Post",
          url: "/urls",
          data: { url: url, bacon: baconString }
        }).done(function(response){
          $("#bacony_url").html(response)
        });

      });


    });

});


