// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Login page text animation
// $('#signin-text-1').fadeIn('slow').delay(10000).fadeOut('slow');
$(document).ready(function() {
	// $(".signin-text-container p:first").css("display", "block");

	// jQuery.fn.timer = function() {
	// 	if (!$(this).children("p:last-child").is(":visible")) {
	// 		$(this).children("p:visible")
	// 			.css("display", "none")
	// 			.next("p").css("display", "block");
	// 	}
	// 	else {
	// 		$(this).children("p:visible")
	// 			.css("display", "none")
	// 		.end().children("p:first")
	// 			.css("display", "block");
	// 	}
	// } // end timer function

	// window.setInterval(function() {
	// 	$(".signin-text-container").timer();
	// }, 1000);

	// var timer_id_1 = setInterval(displayText_1, 4000);

	// function displayText_1() {
	// 	$('#signin-text-1').fadeIn('slow').delay(2000).fadeOut('fast');
	// }

	// var timer_id_2 = setInterval(displayText_2, 2000);

	// function displayText_2() {
	// 	$('#signin-text-2').fadeIn('slow').delay(8000).fadeOut('slow');
	// }
	var counter = 0;
	var timer = setInterval(showText, 5000);

	function showText() {
		counter++;

		console.log(counter);

		$('#signin-text-' + counter.toString()).fadeIn('slow').delay(4000).fadeOut('slow');

		if (counter === 3) {
			counter = 0;
		}
	}
});