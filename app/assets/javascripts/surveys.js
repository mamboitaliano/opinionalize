// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


// AJAX call to make the 'new survey' dialogue fade out and subsequently have 'add question' dialogue
// fade in when the "create" button is clicked
$(document).on("click", "#create_survey_btn", function(e) {
	e.preventDefault();
	console.log("CREATE SURVEY AJAX CALL WORKING----------------------");

	if ( $.trim($("#title").val()).length === 0 ) {
		alert("title field can't be blank");
	}
	else {
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
	}
});

