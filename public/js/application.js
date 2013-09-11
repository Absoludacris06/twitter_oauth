$(document).ready(function() {
	$("#create_tweet").on("submit", function(e) {
	e.preventDefault();
	$(".result").remove();
	$.ajax({
		url: this.action,
		type: this.method,
		data: $(this).serialize()
	})
	.done(function(server_response) {
		console.log("SUCCESS");
		$("#message").html(server_response);
		// append success message
	})
	.fail(function() {
		console.log("FAIL");
		var failure = $("<h5>Your tweet didn't go through.</h5>");
		$("#message").html(failure);
		// append fail message
	});
	});
	$(document).ajaxStart(function() {
    $("#loading").show();
  });
  
  $(document).ajaxStop(function() {
    $("#loading").hide();
  });
});
