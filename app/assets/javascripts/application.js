//= require jquery 
//= require jquery-ui
//= require_tree .
//= require bootstrap-sprockets
//= require jquery.spritely.js

$(document).ready(function() {

// AJAX call to remove a question from the DOM once delete button is hit

  $('.delete-question-form').on('click', function(e) {
    e.preventDefault();
    console.log("DELETE ajax call being hit");

    var form = this;
    var url = $(this).attr("action");
    var type = "DELETE";
    var data = $(this).serialize();

    var request = $.ajax({
      url: url,
      type: type,
      data: data
    });

    request.done(function(ajaxDelete) {
      var panel = $(form).parent().parent();
      $(panel).fadeOut(500).done().remove();
    });

    request.fail(function(serverData){
      console.log("FAIL: " + serverData);
    });
  });


  // Function to pan the background image
  
  $('body').pan({fps: 30, speed: 2, dir: 'left'});


  // Useless stuff vv

  // $(document).on('ajax:success', '.delete-question-form', function() {
  //   console.log("IS THIS WORKING YET?");
  //   var panel = $(this).closest('.panel');
  //   panel.fadeOut(function() { panel.remove(); });
  // });

  // $('.question-container').on('submit', "#delete_button", function(e){
  //   e.preventDefault();

  //   console.log("LISTENER HIT")
  //   var form = this;
  //   var path = $(this).attr('action');
  //   var data = $(this).serialize();

  //   var request = $.ajax({
  //     url: path,
  //     type: 'delete',
  //     data: data
  //   });

  //   request.done(function(){
  //     $(form).parent().parent().remove();
  //   });

  //   request.fail(function(){
  //     console.log("FAILURE");
  //   });
  // });
  // 
});
