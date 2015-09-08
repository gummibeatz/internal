//= require models/Assessment
var AssessmentsCollection = APICollection.extend({
  model: Assessment,
  url: function() {
    return this.APIURLRoot + "/assessments"
  },
});
