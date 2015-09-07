$(document).ready(function() {
  var developer = new Developer();
  developer.fetch({
    success: function(response) {
      var assessments = developer.get("assessments");
      var attendances = developer.get("attendances");
      var $assessments = $('#assessments');
      var $attendances = $('#attendances');
      for (var i = 0; i < assessments.length; i++) {
        $assessments.append(JSON.stringify(assessments[i]));
      }
      for (var i = 0; i < attendances.length; i++) {
        $attendances.append(JSON.stringify(attendances[i]));
      }
    }
  });
});

