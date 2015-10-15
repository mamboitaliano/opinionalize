//= require jquery 
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

  // AJAX call to add a question to the DOM once 'add question' button is hit
  $('#add_question').on("submit", function(e){
    e.preventDefault();
    console.log("SUBMIT!-----------------------------------------------")

    var form = this;
    var url = $(this).attr("action");
    var type = "PUT";
    var data = $(this).serialize();

    var request = $.ajax({
      url: url,
      type: type,
      data: data
    });

    request.done(function(questionPartial){
      console.log(questionPartial);
      $($('#add_question').children()[2]).val('');
      $(questionPartial).hide().appendTo('.question-container').fadeIn(500);
    });

    request.fail(function(serverData){
      console.log("FAIL: " + serverData);
    });
  });

  // Pan background image
  $('body').pan({fps: 30, speed: 2, dir: 'left'});

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

  // Monkey animation
  // $('#monkey').sprite({fps: 6, no_of_frames: 5})
  //   .spRandom({
  //             top: 0,
  //             left: 1200,
  //             right: 100,
  //             bottom: 0,
  //             speed: 4000,
  //             pause: 3000
  //         })
  //   .isDraggable();
  //   .activeOnClick();
  //   .active();
});
