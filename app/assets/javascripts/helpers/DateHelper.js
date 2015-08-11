var DateHelper = {
  formatParsable: function(dateString) {
    var parts = dateString.split('/').length > 1 ? dateString.split('/') : dateString.split('-');
    if (dateString.match('-') !== null) {
      return parts[0] + parts[1] + parts[2];
    } else {
      return parts[2] + parts[0] + parts[1];
    }
  }
}
