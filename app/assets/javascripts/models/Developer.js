var Developer = Backbone.Model.extend({
   urlRoot: '/developers/stats',
   attendances: new AttendancesCollection(),
   assessments: new AssessmentsCollection()
});

