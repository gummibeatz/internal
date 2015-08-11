var ExitTicket = Backbone.Model.extend({
  initialize: function(opts) {
    this.additionalComments = opts.additional_comments;
    this.certainty = opts.certainty;
    this.developerID = opts.developer_id;
    this.difficulty = opts.difficulty;
    this.communication = opts.instructors_ability_to_communicate;
    this.stimulation = opts.instructors_ability_to_stimulate;
    this.overallQuality = opts.overall_quality;
    this.paceAndSpeed = opts.pace_and_speed;
    this.questions = opts.questions;
    this.recall = opts.recall_information_from_previous_class;
    this.score = opts.score;
    this.type = opts.type;
    this.understanding = opts.understanding;
  }

});

