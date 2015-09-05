var Developer = Backbone.Model.extend({
   urlRoot: '/developers/stats'
});



var addDevStats = function() {
  $.getJSON("/developers/stats", function(data) {
    var attendance = data["attendance"];
    var assessments = data["assessments"];
    console.log(attendance);
    console.log(assessments);
    jQuery.each(attendance, function(i,val) {
      console.log(val);
      $("#developer_stats").append(
          val["status"] +"|"+ val["count"]+"</br>"
          );
    });
  });
};

$(document).ready(addDevStats);
$(document).on('page:load', addDevStats);
