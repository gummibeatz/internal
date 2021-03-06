// THIS FILE: Javascript for route /exit_tickets (and /exit_tickets/report) for displaying stats over various periods of time


// Get the raw (json) xittix data
$.ajax({
  url: "/admin/reports",
  type: "GET",
  dataType: 'json',
  response: "{}",
  success: function(response) {
    console.log(response);
    // dataValidation(response);
  },

  error: function(error) {
    console.log(error);
  }
})



// Clean up data; gets called in the ajax success. Then calls graphData(jsonData).
// Cause sometimes people are 1000000% confident
function dataValidation(jsonData) {
// TODO: error catching? What if it's not even a number?
  jsonData.forEach(function(j) {
    if ( parseInt(j.certainty) > 100 ) {
      j.certainty = "100";        
    }
    if(j.certainty === 'undefined') {
      j.certainty = 1;
      console.log("undefined");
    }
    if(!j.score) {
      j.score = 1;
      console.log("score is undefined");
    }
    if(!j.quality) {
      j.quality = 1;
      console.log("quality is undefined");
    }
    if(!j.difficulty) {
      j.difficulty = 1;
      console.log("difficulty is undefined");
    }
    if(!j.communication) {
      j.communication = 1;
      console.log("communication is undefined");
    }
    if(!j.stimulation) {
      j.stimulation = 1;
      console.log("stimulation is undefined");
    }
    if(!j.pace_and_speed) {
      j.pace_and_speed = 1;
      console.log("pace_and_speed is undefined");
      console.log(j.pace_and_speed);
    }    
    if(!j.understanding) {
      j.understanding = 1;
      console.log("understanding is undefined");
    }
    if(!j.recall) {
      j.recall = 1;
      console.log("recall is undefined");
    }

  });

  // graph it
  graphData(jsonData);
}


//these are the things we'll need when updating the chart from html forms
var svg, chart, x, legend;

// D3/dimple function that gets called after data validation
function graphData(jsonData) {
// TODO: any error catching necessary?

  console.log("in graph Data");

  //create svg, chart....will show up in the div "#chart" in index.html.erb
    svg = dimple.newSvg("#chart", 900, 600);
    chart = new dimple.chart(svg, jsonData);
    chart.setBounds(60,50,600,450); //play around w this

    console.log("after creating chart");

  // create series from the json data
    //set input and output date formats
    var inputFormat = "%Y-%m-%dT00:00:00.000Z";
    x = chart.addTimeAxis("x", "submitted_at", inputFormat, "%m/%d");
    x.overrideMin = 1436227200000; // June 7 2015
   // var  y = chart.addMeasureAxis("y", "certainty")
   //   y2 = chart.addMeasureAxis(y, "score"),
   var  y3 = chart.addMeasureAxis("y", "quality");
   var  y4 = chart.addMeasureAxis("y", "difficulty");
   var   y5 = chart.addMeasureAxis("y", "communication");
   //   y6 = chart.addMeasureAxis(y, "stimulation"),
   //   y7 = chart.addMeasureAxis(y, "pace_and_speed"),
   //   y8 = chart.addMeasureAxis(y, "understanding"),
   //   y9 = chart.addMeasureAxis(y, "recall");

  // look pretty
    x.ouputFormat = "%m/%d";
    x.title = "Date";
  //  y.title = "Quantitative Questions";

  //Add all the series you want! These get added to the chart in this order. (i.e. chart[0] is the "Quality" line, chart[1] is the "Difficulty" line etc)
   chart.addSeries(["Quality"], dimple.plot.line, [x, y3]).aggregate = dimple.aggregateMethod.avg;
    chart.addSeries(["Difficulty"], dimple.plot.line, [x, y4]).aggregate = dimple.aggregateMethod.avg;
  chart.addSeries(["Communication"], dimple.plot.line, [x, y5]).aggregate = dimple.aggregateMethod.avg;
//  chart.addSeries(["Interest"], dimple.plot.line, [x, y6]).aggregate = dimple.aggregateMethod.avg;
//  chart.addSeries(["Speed"], dimple.plot.line, [x, y7]).aggregate = dimple.aggregateMethod.avg;
//  chart.addSeries(["Understanding"], dimple.plot.line, [x, y8]).aggregate = dimple.aggregateMethod.avg;
//  chart.addSeries(["Recall"], dimple.plot.line, [x, y9]).aggregate = dimple.aggregateMethod.avg;

  //add a legend
  legend = chart.addLegend("70%", "60%", 0, 200);

  console.log("before drawing chart");

  chart.draw();

  console.log("after drawing chart");

  toggleSeries();

}


function toggleSeries() {
  
  console.log(" in toggleSeries");

  // Below section for toggling series on the chart

  // HOW THIS WORKS: toggleIdxs is a bool[] for knowing which chart.series is on/off by series index (series get added in order of chart.addSeries in the section above). toggleOn is the name of the series ("Quality"), grabbed from the name of the legend item (aggField slice) and matches with the appropriate series index using categoryNames[].
  var toggleIdxs = [0,0,0,0,0,0,0], //7 of them
     toggleOn = [],
     categoryNames = ["Quality", "Difficulty", "Communication", "Interest", "Speed", "Understanding", "Recall"];

  // .on(click) event for each rectange in the legend
  legend.shapes.selectAll("rect")
    .on("click", function(e) {

    //get the name of the legend item that has been clicked
    toggleOn = e.aggField.slice(-1)[0];
    for (var i=0; i<categoryNames.length; i++) {
      //find the corresponding series index for the name
      if (toggleOn === categoryNames[i]) {
        // display off ('none') for that series
        chart.series[i].shapes.style('display',
          toggleIdxs[i] ? '' : 'none');
        // grey out the legend rectangle
        d3.select(this).style("opacity", (toggleIdxs[i] ? 1 : 0.2) );
        // for distinguishing "on" and "off"
        toggleIdxs[i] = (!toggleIdxs[i]);
      }
    }
  });


}


//initialize start and end dates for range
var start = new Date("07/07/2015");
var end = new Date();
//make sure we call the display...() fn at the start
displayAccuracyAndCompletion();

// set start of date range from date picker
function startRange(form) {
  var startDate = new Date(form.startDate.value);
  if (startDate > end) {
    alert("Invalid Start Date");
    return;
  }
  var startDateUTC = Date.parse(startDate);
  x.overrideMin = startDateUTC;
  chart.draw(0, true);
  toggleSeries();
  start = startDate;
  displayAccuracyAndCompletion();
}

// set end of date range from date picker
function endRange(form) {
  var endDate = new Date(form.endDate.value);
  if (endDate < start) {
    alert("Invalid End Date");
    return;
  }
  var endDateUTC = Date.parse(endDate);
  x.overrideMax = endDateUTC;
  chart.draw(0,true);
  toggleSeries();
  end = endDate;
  displayAccuracyAndCompletion();
}

//Display accuracy and completion data
function displayAccuracyAndCompletion() {

  //get the accuracy and completion data
  $.ajax({
    url: "/api/v1/exit_tickets/report",
    data: { start_date: start,
        end_date: end },
    type: "GET",
    success: function(response) {
      var displayAcc = Math.floor(response.accuracy*100);
      var displayCompl = Math.floor(response.completion*100);
      document.getElementById("accuracy").innerHTML = displayAcc;
      document.getElementById("completion").innerHTML = displayCompl;
    },
    error: function(error) {
        console.log(error); }
     });

}
