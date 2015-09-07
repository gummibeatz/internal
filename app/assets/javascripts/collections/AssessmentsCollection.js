var AssessmentsCollection = APICollection.extend({
  url: function() {
    return this.APIURLRoot + "/assessments"
  },
});
