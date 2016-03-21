// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require moment
//= require bootstrap-datetimepicker
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .

$(function(){
  $(".datetimepicker").datetimepicker({
    format: "YYYY-MM-DD h:mm a"
  });
});

$(function(){
  $("#date-search").datetimepicker({
    format: "YYYY-MM-DD"
  });
});

// Enable Search button only when all fields are filled in
$(function (){
    validate();
    $('#start_point, #end_point, #date-search').bind('change dp.change', validate);
});

function validate(){
    if ($('#start_point').val().length   >   0   &&
        $('#end_point').val().length  >   0 &&
        $("#date-search").data("DateTimePicker").date().date.length > 0 ){
        $("input[type=submit]").prop("disabled", false);
    }
    else {
        $("input[type=submit]").prop("disabled", true);
    }
}
