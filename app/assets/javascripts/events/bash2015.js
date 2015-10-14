function PledgeFetcher() {
  this.pledges = [];
  this.total = 0;
  this.previousCount = 0;
  this.updateListener;
}

PledgeFetcher.prototype = {
  run: function() {
    var self = this;
    setInterval(function() {
      self.fetchPledges();
    }, 2000);
  },

  fetchPledges: function() {
    var self = this;
    $.ajax({
      url: "/api/v1/bash2015",
      type: "get",
      success: function(response) {
        self.pledges = response.pledges;
        self.total = response.total;
        self.updateListener();
      },
      error: function() { }
    });
  }
}

function updateProgress(fetcher) {
  var goal = 15000;
  var firstTier = 5000;
  var secondTier = 10000;
  var thirdTier = goal;

  var total = fetcher.total < 5000 ? fetcher.total : fetcher.total + 5000;
  var firstAmount = Math.min(total, firstTier) / firstTier / 3 * 100;
  var secondAmount = total < 5000 ? 0 : 33.4;
  var thirdAmount = total < secondTier ? 0 : (total - secondTier) / firstTier / 3 * 100;
  $('#first-tier').css('width', Math.min(100 / 3, firstAmount) + "%");
  $('#second-tier').css('width', Math.min(100 / 3, secondAmount) + "%");
  $('#third-tier').css('width', Math.min(100 / 3,thirdAmount) + "%");
}

$(document).ready(function() {

  var idx = 0;


  var fetcher = new PledgeFetcher();
  fetcher.run();

  fetcher.updateListener = function() {
    updateProgress(fetcher);
    $('#total').html("Total Pledged: <span class='green'>$" + fetcher.total + "</span>");
  };

  setInterval(function() {
    if (!fetcher.pledges.length) {
      return;
    }

    var pledge = fetcher.pledges[idx];
    var amount = pledge.amount;
    var message = pledge.message;
    var name = pledge.donor.name;

    if (!name || name === "") {
      return;
    }

    idx = (1 + idx) % fetcher.pledges.length;

    var string = name + " just pledged $" + amount;
    var message = message;

    var $donations = $('#donation');
    var $display = $donations.find('.display');
    var $message = $donations.find('.message');

    $donations.fadeOut(function() {
      $display.text(string);
      $message.text("\"" + message + "\"");
      $donations.fadeIn();
    });


  }, 4000);


});
