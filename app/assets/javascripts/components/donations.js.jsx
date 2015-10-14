var TotalDonation = React.createClass({
  loadDonationFromServer: function() {
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
    this.loadDonationFromServer();
    setInterval(this.loadDonationFromServer, this.props.pollInterval);
  },

  isSuccess: function() {
    if(this.state.data.total_amount > 5000) { return "success-style" }
    return ""
  },

  render: function() {
    var style = "text-center ";
    return(
      <h2 className = {style.concat( this.isSuccess() )}>
        {this.state.data.total_amount} / 5000
      </h2>
    );
  } 
})

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
    setInterval(this.loadDonationFromServer, this.props.pollInterval);
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
        {this.props.data.message},{this.props.data.amount}/>
      </div>
    );
  }
});

$(function() {
  var pollInterval = 2000;
  var $content = $("#total-donation");
  if($content.length > 0) {
    React.render(
      <TotalDonation url = "/api/v1/event_donation.json" pollInterval={pollInterval}/>,
      document.getElementById("total-donation")
    );
  }

  if($("#donation-box").length > 0) {
    React.render(
      <DonationBox url = "/api/v1/bash2015.json" pollInterval= {pollInterval}/>,
      document.getElementById("donation-box")
    );
  }
});
