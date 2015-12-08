// = require jquery 
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




  // AJAX call to make the 'new survey' dialogue fade out and subsequently have 'add question' dialogue
  // fade in when the "create" button is clicked
  $('#create_survey_btn').on("click", function(e) {
    e.preventDefault();
    console.log("CREATE SURVEY AJAX CALL WORKING----------------------");

    var form = $(this).parent().children().eq(1).children();
    var url = $(form).attr("action");
    var type = "POST";
    var data = $(form).serialize();

    var request =$.ajax({
      url: url,
      type: type,
      data: data
    });

    request.done(function(serverData) {
      console.log("Here is the serverData:");
      console.log(serverData);
      console.log("------------------------end--------------------------");

      // Make .survey-title-container fade out and make .ajax-container fade in
      $('.survey-title-container').fadeOut(500).promise().done(function() {
        $('.survey-title-container').remove();
        $(".ajax-container").delay(500).append(serverData).hide().fadeIn("slow");
      });
    });
  });




  // Allows the 'new-question-form' to fade in when the "Add Question" button is clicked
  $(document).on('click', '#show-question-form', function(e) {
    e.preventDefault();

    var link_value = document.getElementById("show-question-form").getAttribute("href");
    console.log(link_value);

    $('.add-question-prompt-container').fadeOut(500).promise().done(function() {
      $('.add-question-prompt-container').remove();
      // $('.edit_survey_partial').append('.new-question-form').fadeIn("slow");
    });
    console.log("container removed");
    $(".content").load(link_value);
  });




  $(document).on('click', '#add-question-btn', function(e) {
    e.preventDefault();
    console.log("ADD QUESTION AJAX CALL WORKING----------------------");
    
    var form = $(this).parent();
    var url = $(form).attr('action');
    var type = "POST";
    var data = $(form).serialize();

    console.log(data);
    debugger

    var request = $.ajax({
      url: url,
      type: type,
      data: data
    });

    request.done(function(serverData) {
      // TODO: LOGIC TO REMOVE FORM AND DISPLAY NEWLY CREATED QUESTION
      console.log("trace complete")
      $('#add_question')[0].reset();
      $('.new-question-form').animate({
        top: '+=35'
      }, 500 ).promise().done(function() {
        $('.content').prepend('<h4 class="question-text">TEST</h3>').hide().fadeIn("slow");
      });

      // $('.new-question-form').fadeOut(500).promise().done(function() {  
      //   $('.new-question-form').html('<p>HI HI HI</p>').fadeIn(300);
      //   // $('.add_question').remove();
      // });
    });

    request.fail(function(serverData) {
      // TODO: LOGIC TO HANDLE ERROR CREATING NEW QUESTION
    })

    console.log("------------------------end--------------------------");
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
});
