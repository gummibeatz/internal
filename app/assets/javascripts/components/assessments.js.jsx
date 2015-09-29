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
        <AssessmentList data = {this.state.data} />
      </div> 
    );
  }
});


var AssessmentScore = React.createClass({

  formatScore: function() {
    var classes = ['danger text-danger', 'caution text-caution', 'success text-success', 'success text-success'];
    var score = this.props.data.score;
    var divStyle = {color: 'black'};
    console.log(score);
    if(this.props.data.type == "homework") {
      this.props.data.klass = classes[score];
    }
    return <span className={this.props.data.klass}>{score} out of {this.props.data.max_score}</span>;
  },

  render: function() {
    return(
      <span>{this.formatScore()}</span>  
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
      <div className = "assessment">
        <span>
          <strong>score: </strong> <AssessmentScore data = {this.props.data} /> <br/>
          <strong>github url: </strong> <a href={this.props.data.github_url}>{this.props.data.github_url}</a> <br/>
          <strong>due date: </strong>{this.props.data.due_at}
        </span>
      </div>
    );
  }
});


var AssessmentList = React.createClass({
  
  render: function() {
    var assessmentNodes = this.props.data.map(function (assessment) {
      return (
        <div>
          <AssessmentReact data = {assessment}/>
          <br/>
        </div>
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
  var pollInterval = 2000
  var $content = $("#assessments-panel");
  if($content.length > 0) {
    React.render(
      <AssessmentBox url = "/api/v1/assessments.json" pollInterval={pollInterval}/>,
      document.getElementById("assessments-panel")
    );
  } else if ($("#admin-dev-assessments-panel").length > 0) {
    var currentURL = window.location.href.split("/");
    var developer_id = currentURL[currentURL.length-1];
    var url = "/api/v1/assessments.json?developer_id=".concat(developer_id);
    React.render(
      <AssessmentBox url = {url} pollInterval= {pollInterval}/>,
      document.getElementById("admin-dev-assessments-panel")
    );
  }
});
