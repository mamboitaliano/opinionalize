//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap-sprockets
//= require jquery.spritely.js


$(document).ready(function() {

  $(document).on('ajax:success', '.delete-question-form', function(){
    var panel = $(this).closest('.panel');
    panel.fadeOut(function(){ panel.remove(); });
  });

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


  // $('#add_question').on("submit", function(e){
  //   console.log("SUBMIT!")
  //   e.preventDefault();

  //   var form = this;
  //   var url = $(this).attr("action");
  //   var type = "POST";
  //   var data = $(this).serialize();

  //   var request = $.ajax({
  //     url: url,
  //     type: type,
  //     data: data
  //   });

  //   request.done(function(questionPartial){
  //     console.log(questionPartial)
  //     $($('#add_question').children()[2]).val('')
  //     $('.question-container').append(questionPartial);

  //   });
  //   request.fail(function(serverData){
  //     // console.log("FAIL: " + serverData)
  //   });

  // });

  $('body').pan({fps: 30, speed: 2, dir: 'left'});
  $('#monkey').sprite({fps: 6, no_of_frames: 5})
    .spRandom({
              top: 0,
              left: 1200,
              right: 100,
              bottom: 0,
              speed: 4000,
              pause: 3000
          })
    .isDraggable()
    .activeOnClick()
    .active();
});
