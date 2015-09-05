var Developer = Backbone.Model.extend({
   urlRoot: '/developers/stats'
});

$(document).ready(function() {
  var developer = new Developer();
  developer.fetch({
    success: function(response) {
      console.log(response);
    }
  });
});
