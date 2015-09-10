var developer;
$(document).ready(function() {
  developer = new Developer();
  developer.fetch({
    success: function() {
      fetchAttendances();
      fetchAssessments();
    }
  });
});

function fetchAttendances() {
  developer.attendances.fetch({
    success: function(response) {
      var attendances = developer.attendances.models;
      attendances = _.map(attendances, function(attendance) {
        var json = attendance.toJSON();
        json["klasses"] = attendance.klasses();
        return json;
      })

      var units = developer.get('cohort').units;
      var byUnit = _.groupBy(attendances, function(attendance) {
        for (var i = 0; i < units.length; i++) {
          if (attendance.timestamp >= units[i].start_at && attendance.timestamp <= units[i].end_at) {
            return "unit" + units[i].index;
          }
        }
      });

      for (key in byUnit) {
        var atts = byUnit[key];
        byUnit[key] = _.groupBy(atts, function(att) { return att.status; });
      }

      var attendances = {
        "attendances" : byUnit
      };

      Mustache._render('#attendances-template', '#attendances', attendances);
    }
  });
}

function fetchAssessments() {
  developer.assessments.fetch({
    success: function(response) {
      var models = developer.assessments.models;
      var assessments = {
        "assessments" : _.map(models, function(model) {
          var json = model.toJSON();
          json["klasses"] = model.klasses();
          return json;
        })
      };
      Mustache._render('#assessments-template', '#assessments', assessments);
    }
  });
}

