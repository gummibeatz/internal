var developer;
$(document).ready(function() {
  developer = new Developer();
  developer.attendances.fetch({
    success: function(response) {
      var attendances = { "attendances" : _.map(developer.attendances.models, function(model) {
        return model.toJSON();
      })};
      Mustache._render('#attendances-template', '#attendances', attendances);
    }
  });
  developer.assessments.fetch({
    success: function(response) {
      var assessments = { "assessments" : _.map(developer.assessments.models, function(model) {
        return model.toJSON();
      })};
      Mustache._render('#assessments-template', '#assessments', assessments);
    }
  });
});

