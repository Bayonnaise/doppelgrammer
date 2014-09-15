$(document).ready(function() {
	$('.doppel-link').on('click', function(event){
		var voteCount = $(this).siblings('.doppel-count');
		event.preventDefault();
		$.post(this.href, function(response){
			voteCount.text(response.new_count);
		});
	});
});