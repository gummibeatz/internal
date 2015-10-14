TotalDonation = React.createClass({
  loadTotalDonationFromServer: function() {
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
    this.loadTotalDonationFromServer();
    setInterval(this.loadTotalDonationFromServer, this.props.pollInterval);
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

$(function() {
 var pollInterval = 2000
  var $content = $("#total-donation");
  /*
  if($content.length > 0) {
    React.render(
      <TotalDonation url = "/api/v1/event_donation.json" pollInterval={pollInterval}/>,
      document.getElementById("total-donation")
    );
  }
 */

});
