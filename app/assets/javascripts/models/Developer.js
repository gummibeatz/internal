var Developer = APIModel.extend({
  url: function() {
    return this.APIURLRoot + "/developers.json"
  },
  attendances: new AttendancesCollection(),
  assessments: new AssessmentsCollection()
});

