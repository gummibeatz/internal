var developer;
$(document).ready(function() {
  developer = new Developer();
  developer.attendances.fetch({
    success: function(response) {
      var attendances = developer.attendances.models;
      // var html = Mustache.to_html($('#attendances-template').html(), {"attendances" : attendances});
      var html = Mustache.to_html("<div>{{score}}</div>", attendances[0]);
      var $attendances = $('#attendances');
      $attendances.html(html);
      /*
      for (var i = 0; i < attendances.length; i++) {
        $attendances.append(JSON.stringify(attendances[i]));
      }
      */
    }
  });
  developer.assessments.fetch({
    success: function(response) {
      var assessments = _.map(developer.assessments.models, function(model) { return model.toJSON(); });
      var html = Mustache.to_html($('#attendances-template').html(), {"assessments" : assessments});
      var $assessments = $('#assessments');
      $assessments.html(html);
    }
  });
});

