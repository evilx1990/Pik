// animate scroll categories
$(document).on('turbolinks:load', function() {
  $(document).ready(function(){
    $(".anchor").on("click", function (event) {
      event.preventDefault();
      let id  = $(this).attr('href');
      let top = $(id).offset().top;
      $('body,html').animate({ scrollTop: top }, 1000);
    });
  });
});