var AttendanceBox = React.createClass({
  loadAttendancesFromServer: function() {
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
    this.loadAttendancesFromServer();
    // setInterval(this.loadAttendancesFromServer, this.props.pollInterval);
  },

  render: function() {
    console.log(this.state.data);
    return (
      <AttendanceList data = {this.state.data} />
    );
  }
});

var AttendanceList = React.createClass({
  render: function() {
    var attendanceNodes = this.props.data.map(function (attendance) {
      return (
          <AttendanceReact data = {attendance}/>
      );
    });
    return (
      <table className = "table">
        <thead>
          <tr>
            <th>Date</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {attendanceNodes}
        </tbody>
      </table>
    );
  }
});


var AttendanceReact = React.createClass({

  render:function() {
    var styles = {
      'on_time': '',
      'late_excused': '',
      'late_unexcused_5_minutes': 'danger',
      'late_unexcused_10_minutes': 'danger',
      'absent_unexcused': 'danger'
    };
    return(
      <tr className={styles[this.props.data.status]}>
        <td> {this.props.data.timestamp } </td>
        <td> {this.props.data.status.replace(/_/g, " ")} </td>
      </tr>
    );
  }
});

$(function() {
  var pollInterval = 2000;
  if($("#attendances-panel").length >0) {
    React.render(
      <AttendanceBox url = "/api/v1/attendances.json" pollInterval = {pollInterval} />,
      document.getElementById("attendances-panel")
    );
  } else if ($("#admin-dev-attendances-panel").length > 0) {
    var url = "/api/v1/attendances.json?developer_id=".concat(window.developerID);
    console.log(url);
    React.render(
      <AttendanceBox url={url} pollInterval={pollInterval}/>,
      document.getElementById("admin-dev-attendances-panel")
    );
  }
});
