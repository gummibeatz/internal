var Attendance = Backbone.Model.extend({
  initialize: function(opts) {
    this.developerID = opts.developer_id;
    this.status = opts.status;
    this.timestamp = opts.timestamp;
  },

  klasses: function() {
    return "";
  },

  isAbsentExcused: function() {
    return this.get('status') == "absent_excused";
  },

  isAbsentUnexcused: function() {
    return this.get('status') == "absent_unexcused";
  },

  isOnTime: function() {
    return this.get('status') == "on_time";
  },

  isLate: function() {
    var status = this.get('status');
    var excused = status == 'late_excused';
    var unexcused = status == 'late_unexcused_5_minutes' || status == 'late_unexcused_10_minutes';
    return excused || unexcused;
  },

  isLateExcused: function() {
    return this.get('status') == 'late_excused';
  },

  isLateUnexcused: function() {
    var status = this.get('status');
    return  status == 'late_unexcused_5_minutes' || status == 'late_unexcused_10_minutes';
  }
});
