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

  cleanUpMessage: function(message) {
    message = this.removeUsersFromMessage(message);
    return message;
  },

  removeUsersFromMessage: function(message) {
    return message.replace(/<@.*>/, "Some Dev");
  },

  linkifyURLsInMessage: function(message) {
    return message.replace(/<http.*>/, "<a href='$1',$1</a>");
  },
  
  render: function() {
    return(
      <tr>
        <td><div className = "slack-message">{this.cleanUpMessage(this.props.data.text)}</div></td>
      </tr>
    );  
  }
});

$(function() {
  var $content = $("#slack-homework-channel-panel");
  if($content.length > 0) {
    var developerId = window.developerId;
    var url = "/api/v1/slackAPI.json?developer_id=".concat(developerId);
    React.render(<SlackHomeworkChannelBox url = {url}/>,
      document.getElementById("slack-homework-channel-panel")
    );
  }
});
