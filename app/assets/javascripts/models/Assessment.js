var Assessment = Backbone.Model.extend({
  types: { HOMEWORK: 0, EXAM: 1, PROJECT: 2 },
  klasses: function() {
    if (this.get('type') === "homework") {
      var score = this.get('score');
      switch (score) {
        case 0:
          return "danger text-danger";
          break;
        case 1:
          return "caution text-caution";
          break;
        case 2:
          return "success text-success";
          break;
        case 3:
          break;
        default:
          return ""
      }
    }
  }
})
