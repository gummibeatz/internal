var data = [
  {title: "yay"},
  {title: "meeep"}
];

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
    setInterval(this.loadAttendancesFromServer, this.props.pollInterval);
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
      <table className = "table table-striped">
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
    return(
      <tr className="table-row">
        <td> {this.props.data.timestamp } </td>
        <td> {this.props.data.status} </td>
      </tr>
    );
  }
});

$(function() {
  var pollInterval = 2000;
  var $content = $("#attendances-panel");
  if($content.length >0) {
    React.render(
      <AttendanceBox url = "/api/v1/attendances.json" pollInterval = {pollInterval} />,
      document.getElementById("attendances-panel")
    );
  }
});
