DonationBox = React.createClass({
  loadDonationsFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) { 
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  getInitialState: function() {
    return {data: []};
  },

  componentDidMount: function() {
    this.loadDonationsFromServer();
    setInterval(this.loadDonationsFromServer, this.props.pollInterval);
  },

  render: function() {
    return(
      <div>
        <DonationList data = {this.state.data} />
      </div>
    );
  } 
})

DonationList = React.createClass ({
  render: function() {
    var donationNodes = this.props.data.map(function (donation) {
      return(
        <Donation data = {donation}/>
      );
    });

    return(
      <div>{donationNodes}</div>
    );
  }
});

Donation = React.createClass({
  render: function() {
    return(
      <div>
        {this.props.data.message},{this.props.data.amount}
      </div>
    );
  }
});

$(function() {
  var pollInterval = 2000;

  if($("#donation-box").length > 0) {
    React.render(
      <DonationBox url = "/api/v1/bash2015.json" pollInterval= {pollInterval}/>,
      document.getElementById("donation-box")
    );
  }
});


var allDonations =[];

//function doPoll(){
//    $.ajax('ajax/test.html', function(data) {
//      url: "",
//      dataType: 'json',
//      cache: false,
//      success: function(data) { 
//        this.setState({data: data});
//      }.bind(this),
//      error: function(xhr, status, err) {
//        console.error(this.props.url, status, err.toString());
//      }.bind(this)
//    });
//}
