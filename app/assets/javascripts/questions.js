// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


// Allows the 'new-question-form' to fade in when the "Add Question" button is clicked
$(document).on('click', '#show-question-form', function(e) {
	e.preventDefault();
	var link_value = document.getElementById("show-question-form").getAttribute("href");
	console.log(link_value);
	$('.add-question-prompt-container').fadeOut(500).promise().done(function() {
		$('.add-question-prompt-container').remove();
	});
	$(".content").load(link_value);
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


// AJAX call to add question to survey
$(document).on("click", ".add-question-btn", function(e) {
	e.preventDefault();
	if ( $.trim($(".new-question-text-box").val()).length === 0 ) {
		$(".new-question-form p").finish().fadeIn("fast").delay(5000).fadeOut("slow");
	}
	else {
		console.log("ADD QUESTION AJAX CALL WORKING----------------------");
		var form = $(this).parent();
		var url = $(form).attr('action');
		var type = "POST";
		var data = $(form).serialize();
		var request = $.ajax({
			url: url,
			type: type,
			data: data
		});
		request.done(function(serverData) {
			$('#add_question')[0].reset();
			$('.new-question-form').animate({
				top: '+=60'
			}, 500 ).promise().done(function() {
				$('.content').prepend(serverData).hide().fadeIn("slow");
			});
			console.log("Server returning _question_partial.html.erb:")
			console.log(serverData);
		});
		request.fail(function(serverData) {
			// TODO: LOGIC TO HANDLE ERROR CREATING NEW QUESTION
		});
		console.log("------------------------end--------------------------");
	}
});


// Function to open modal dialog box where user can specify response type
$(document).on("click", ".set-resp-type-btn", function(e) {
	e.preventDefault();
	console.log("SET RESPONSE TYPE WORKING--------------------------");
	var link_value = $(this).attr('formaction');
	console.log(link_value);
	$('.modal').load(link_value);
	$('.modal').dialog();
});


// Function to control radio button actions that display the response type options.
// When a radio button is checked, all hidden form input fields are set to disabled and any
// data currently in said fields will not get sent to the db
$(document).on("change", ".optradio", function() {
	if (this.value == "textinput") {
		$('#optradio-r2, #optradio-r3').hide(function() {
			// TODO: disable other fields to prevent them from being submitted
			$('.mc-answerchoice, .ma-answerchoice').prop("disabled", true); // <--- you could also select by fieldset id
			$('.txtinput-resp').prop("disabled", false);
			$('#optradio-r1').show();
		});
	}
	else if (this.value == "multichoice") {
		$('#optradio-r1, #optradio-r3').hide(function() {
			// TODO: disable other fields to prevent them from being submitted
			$('.txtinput-resp, .ma-answerchoice').prop("disabled", true);
			$('.mc-answerchoice').prop("disabled", false);
			$('#optradio-r2').show();
		});
	}
	else {
		$('#optradio-r1, #optradio-r2').hide(function() {
			// TODO: disable other fields to prevent them from being submitted
			$('.txtinput-resp, .mc-answerchoice').prop("disabled", true);
			$('.ma-answerchoice').prop("disabled", false);
			$('#optradio-r3').show();
		});
	}
});


// Functions to add an answer choice to a multiple choice and multiple answer question
// Includes logic to auto-letter each answer choice (e.g. a, b, c...)
function nextChar(c) {
	return String.fromCharCode(c.charCodeAt(0) + 1);
}
var mc_choice_count = 3;
$(document).on('click', "#mc-add-choice", function() {
	var prev_td = "#l" + (mc_choice_count - 1);
	var prev_letter = $(prev_td).text();
	var current_letter = nextChar(prev_letter);
	var content = "<tr><td class='numerator' id='l" + mc_choice_count + "'>" + current_letter + "</td><td><input class='mc-answerchoice' id='" + current_letter + "' type='text' name='mc-answerchoice" + mc_choice_count + "' placeholder='write an answer choice'></td></tr>";
	$("#actbl1").append(content);
	mc_choice_count++;
});
var ma_choice_count = 3;
$(document).on('click', "#ma-add-choice", function() {
	var prev_td = "#n" + (ma_choice_count - 1);
	var prev_letter = $(prev_td).text();
	var current_letter = nextChar(prev_letter);
	var content = "<tr><td class='numerator' id='n" + ma_choice_count + "'>" + current_letter + "</td><td><input class='ma-answerchoice' id='" + current_letter + "' type='text' name='ma-answerchoice" + ma_choice_count + "' placeholder='write an answer choice'></td></tr>";
	$("#actbl2").append(content);
	ma_choice_count++;
});


// Function to control radio buttons that allow user to choose between a short and a long text input response
$(document).on("change", ".txtinput-resp", function () {
	if (this.name = "txt-answerchoice") {
		// alert("this is working");
		// TODO: set the response input type (in the db) to text

	}
	else {
		// alert("this is working too");
		// TODO: set the response input type (in the db) to textarea
	}
});



// AJAX call to set the response type and answer choices for a given question
$(document).on("submit", "#resp-type-submit-form", function(e) {
	e.preventDefault();
	console.log("update response type AJAX CALL WORKING----------------------");
	var url = $(this).attr('action');
	var data = $(this).serialize();
	var request = $.ajax({
		url: url,
		type: "PUT",
		data: data
	});
	request.done(function(serverData) {
		// TODO: record successful UPDATE operation in log, remove modal dialog box from DOM
		$("#resp-type-form-box").remove();
		$(".modal").dialog("close");
		console.log(this.data);
		var q_id_start = this.url.indexOf("questions") + 10;
		var q_id = this.url.substring(q_id_start, this.url.length);
		debugger
		if (this.data.search("multichoice") >= 0) {
			$("#q" + q_id + "-status").text("multiple choice");	
		}
		else if (this.data.search("chkboxes") >= 0) {
			$("#q" + q_id + "-status").text("checkboxes");	
		}
		else {
			if (this.data.search("txt-short") >= 0) {
				$("#q" + q_id + "-status").text("short text");	
			}
			else if (this.data.search("txt-paragraph") >= 0) {
				$("#q" + q_id + "-status").text("paragraph");	
			}
		}
	});
	request.fail(function(serverData) {
		console.log("error writing response type and options to databse");
		// TODO: record UPDATE failure in log
	});
});



// Sets action for when the "cancel" button is clicked
$(document).on("click", ".cancel-button", function(e) {
	e.preventDefault();
	$("#resp-type-form-box").remove();
	$(".modal").dialog("close");
});



// AJAX calls to set a question's "required" property to true or false
// TODO: why does request keep hitting .fail instead of .done when the data is being successfully written to the db?
// control what happens when user sets "required" to yes
$(document).on("click", "#required-yes", function(e) {
	e.preventDefault();
	var request = $.ajax({
		url: $(this).attr("href"),
		type: "PUT",
		dataType: "json",
		data: {"required": "true"}
	});
	request.done(function(serverData) {
		console.log("what what: " + serverData);
	});
	request.fail(function(serverData) {
		console.log("failed to set required question parameter");
	});
});
// control what happens when user sets "required" to no
$(document).on("click", "#required-no", function(e) {
	e.preventDefault();
	var request = $.ajax({
		url: $(this).attr("href"),
		type: "PUT",
		dataType: "json",
		data: {"required": "false"}
	});
	request.done(function(serverData) {
		console.log("what what: " + serverData);
	});
	request.fail(function(serverData) {
		console.log("failed to set required question parameter");
	});
});

