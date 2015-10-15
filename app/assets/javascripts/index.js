// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Login page cyclical text animation
$(document).ready(function() {

	var counter = 0;
	var timer = setInterval(showText, 5000);

	function showText() {
		counter++;

		console.log(counter); // for debugging

		$('#signin-text-' + counter.toString()).fadeIn('slow').delay(4000).fadeOut('slow');

		if (counter === 3) {
			counter = 0;
		}
	}
});