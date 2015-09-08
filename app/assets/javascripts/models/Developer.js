var Developer = APIModel.extend({
  url: function() {
    return this.APIURLRoot + "/developer"
  },
   attendances: new AttendancesCollection(),
   assessments: new AssessmentsCollection()
});

