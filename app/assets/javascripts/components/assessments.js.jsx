var data = [
  {max_score: 3.0, github_url: "http://github.com"},
  {max_score: 2.0, github_url: "http://github.com"}
];

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
        <h1>AssessmentsBox</h1>
        <AssessmentList data = {this.state.data} />
      </div> 
    );
  }
});

var AssessmentReact = React.createClass({
  
  rawMarkup: function() {
    var rawMarkup = marked(this.props.children.toString(), {sanitize: true});
    return { __html: rawMarkup };
  },

  render: function() {
    return(
      <div className = "assessmentReact">
        <div className = "assessmentTimestamp">
          { this.props.status }
        </div>
        <span dangerouslySetInnerHTML = {this.rawMarkup()} />
      </div>
    );
  }
});


var AssessmentList = React.createClass({
  
  render: function() {
    var assessmentNodes = this.props.data.map(function (assessment) {
      return (
        <AssessmentReact max_score={assessment.max_score}>
          {assessment.github_url}
        </AssessmentReact>
      );
    });

    return(
      <div className="assessmentList">
      {assessmentNodes}
      </div>
    );
  }

});


$(function() {
  var $content = $("#content");
  if($content.length >0) {
    React.render(
      <AssessmentBox url = "/api/v1/assessments.json" pollInterval={2000}/>,
      document.getElementById("content")
    );
  }
});
