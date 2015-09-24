var AttendanceBox = React.createClass({

  render: function() {
    return(
      <div>
        <h1 >Attendance</h1>
        <AttendanceList/>
      </div> 
    );
  }
});

var AttendanceReact = React.createClass({
  
  rawMarkup: function() {
    var rawMarkup = marked(this.props.children.toString(), {sanitize: true});
    return { __html: rawMarkup };
  },

  render: function() {
    return(
      <div className = "attendanceReact">
        <div className = "attendanceTimestamp">
          { this.props.status }
        </div>
        <span dangerouslySetInnerHTML = {this.rawMarkup()} />
      </div>
    );
  }
});


var AttendanceList = React.createClass({
  
  render: function() {
    return(
      <div className="attendanceList">
        <AttendanceReact s = "late" > This is one attendance </AttendanceReact>
      </div>
    );
  }

});


$(function() {
  var $content = $("#content");
  if($content.length >0) {
    React.render(
      <AttendanceBox />,
      document.getElementById("content")
    );
  }
});
