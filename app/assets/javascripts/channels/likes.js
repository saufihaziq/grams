$(document).on('turbolinks:load', function() {
  $('.likes-link').on('click', function(event) {
    event.preventDefault();
    var likeCount = $(this).siblings('.likes_count');

    $.post(this.href, function(response) {
      likeCount.text(response.new_like_count);

      
    });

  });

});


// $(document).on('turbolinks:load', function - the fix for js not working after going to new page
// $(document).ready(function