var developer;
$(document).ready(function() {
  developer = new Developer();
  developer.attendances.fetch({
    success: function(response) {
      var attendances = developer.attendances.models;
      var $attendances = $('#attendances');
      for (var i = 0; i < attendances.length; i++) {
        $attendances.append(JSON.stringify(attendances[i]));
      }
    }
  });
  developer.assessments.fetch({
    success: function(response) {
      var assessments = developer.assessments.models;
      var $assessments = $('#assessments');
      for (var i = 0; i < assessments.length; i++) {
        $assessments.append(JSON.stringify(assessments[i]));
      }
    }
  });
});

