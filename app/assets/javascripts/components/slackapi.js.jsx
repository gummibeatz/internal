var SlackHomeworkChannelBox = React.createClass({
  loadMessagesFromServer: function() {
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
    return{data: []};
  },

  componentDidMount: function() {
    this.loadMessagesFromServer();
  },

  render: function() {
    return(
        <HomeworkMessageList data = {this.state.data} />
    );
  }
});

var HomeworkMessageList = React.createClass({
  
  render: function() {
    var homeworkMessageNodes = this.props.data.map(function (message){
      return (
        <HomeworkMessage data = {message}/>
      );
    });
    
    return(
      <table className = "table">
        <thead>
          <tr>
            <th>Messages</th>
          </tr>
        </thead>
        <tbody>
          {homeworkMessageNodes}
        </tbody>
      </table>
    );
  }
});

var HomeworkMessage = React.createClass({
  render: function() {
    return(
      <tr>
        <td><div className = "slack-message">{this.props.data.text}</div></td>
      </tr>
    );  
  }
});

$(function() {
  var $content = $("#slack-homework-channel-panel");
  if($content.length > 0) {
    React.render(<SlackHomeworkChannelBox url = "/api/v1/slackAPI.json"/>,
      document.getElementById("slack-homework-channel-panel")
    );
  }
});
