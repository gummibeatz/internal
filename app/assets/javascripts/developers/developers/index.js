var developer;
$(document).ready(function() {
  developer = new Developer();

  developer.fetch({
    success: function(response) {
      console.log(response);
    }
  });

  developer.attendances.fetch({
    success: function(response) {
      var models = developer.attendances.models;
      models = _.map(models, function(model) {
        var json = model.toJSON();
        json["klasses"] = model.klasses();
        return json;
      })
      var grouped = _.groupBy(models, function(m) { return m.status; });
      var attendances = {
        "attendances" : models
      };
      Mustache._render('#attendances-template', '#attendances', attendances);
    }
  });

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
});

