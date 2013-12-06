// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(document).ready(function() {

  $('#category_choices_submit').on('click', function(event)
  {
    event.preventDefault();
    var categoryChoice = $('#category_choices').val();
    var url = '/projects/by_category';
    $.ajax({
      url: url,
      dateType: 'script',
      data: {
        category_choice: categoryChoice
      },
      success: function(result) {
        eval(result);
      }
    });
  });

});

$(function(){ $(document).foundation(); });

$(document).foundation({
  tab: {
    callback : function (tab) {
      console.log(tab);
    }
  }
});

