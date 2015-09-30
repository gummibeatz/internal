var AssessmentBox = React.createClass({
  loadAssessmentsFromServer: function() {
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
    this.loadAssessmentsFromServer();
    setInterval(this.loadAssessmentsFromServer, this.props.pollInterval);
  },
  
  render: function() {
    return(
      <div>
        <AssessmentList data = {this.state.data} />
      </div> 
    );
  }
});



var AssessmentReact = React.createClass({

    getStyleColor: function() {
      if(this.props.data.score < 1) {return "danger"}
      if(this.props.data.type == "homework") {
        if(this.props.data.score < 2) {return "warning"}
      }
    },
  
  render: function() {
    return(
        <tr className ={this.getStyleColor()}>
          <td>{this.props.data.type}</td>
          <td>{this.props.data.due_at}</td>
          <td>{this.props.data.score}/{this.props.data.max_score}</td>
          <td><a href={this.props.data.github_url}>{this.props.data.github_url}</a></td>
        </tr>
   );
  }
});


var AssessmentList = React.createClass({
  
  render: function() {
    var assessmentNodes = this.props.data.map(function (assessment) {
      return (
          <AssessmentReact data = {assessment}/>
      );
    });

    return(
      <table className = "table">
        <thead>
          <tr>
            <th>Type</th>
            <th>Due Date</th>
            <th>Grade</th>
            <th>Github URL</th>
          </tr>
        </thead>
        <tbody>
          {assessmentNodes}
        </tbody>
      </table>
    );
  }
          
});


$(function() {
  var pollInterval = 2000;
  var $content = $("#assessments-panel");
  if($content.length > 0) {
    React.render(
      <AssessmentBox url = "/api/v1/assessments.json" pollInterval={pollInterval}/>,
      document.getElementById("assessments-panel")
    );
  } else if ($("#admin-dev-assessments-panel").length > 0) {
    var url = "/api/v1/assessments.json?developer_id=".concat(window.developerID);
    React.render(
      <AssessmentBox url = {url} pollInterval= {pollInterval}/>,
      document.getElementById("admin-dev-assessments-panel")
    );
  }
});
