var AttendancesCollection = APICollection.extend({
  url: function() {
    return this.APIURLRoot + "/attendances"
  },

  present: function() {
    return _.reject(this.models, function(model) {
      return model.isAbsentExcused() || model.isAbsentUnexcused();
    });
  },

  late: function() {
    return _.filter(this.models, function(model) {
      return model.isLate();
    });
  },

});
