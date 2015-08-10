//Javascript for creating graphs for exit ticket numerical data.


// Get the xittix data from the rb request
$.ajax({
  url: "/exit_tickets",
  type: "GET",
  dataType: 'json',
  response: "{}",
  success: function(response) {
    console.log(response);
    dataValidation(response);
  },

  error: function(error) {
    console.log(error);
  }
})




// TODO: error catching?
// Clean up data; gets called in the ajax success. Then calls graphData(jsonData).
//cause sometimes people are 1000000% confident
function dataValidation(jsonData) {
	jsonData.forEach(function(j) {
		if ( parseInt(j.certainty) > 100 ) {
			j.certainty = "100";
		}
	});

	//now we can graph it
	graphData(jsonData);
}


//these are the things we'll need when updating the chart from html forms
var svg;
var chart;
var x; 

// TODO: scrollable x range
// TODO: error catching?
// D3/dimple function that gets called after data validation
function graphData(jsonData) {

		//var filteredValues = dimple.filterData(data, "Instructor", "Amy")...nb: this is how you filter out data if you need to use it eventually...

	//create svg, chart....will show up in the div "#chart" in index.html.erb
		svg = dimple.newSvg("#chart", 900, 600);
		chart = new dimple.chart(svg, jsonData);
		chart.setBounds(60,50,600,450); //play around w this

	// create series from the json data
		x = chart.addTimeAxis("x", "submitted_at");
		x.overrideMin = 1436227200000;
		var	y = chart.addMeasureAxis("y", "certainty"),
			y2 = chart.addMeasureAxis(y, "score"),
			y3 = chart.addMeasureAxis(y, "overall_quality"),
			y4 = chart.addMeasureAxis(y, "difficulty"),
			y5 = chart.addMeasureAxis(y, "instructors_ability_to_communicate"),
			y6 = chart.addMeasureAxis(y, "instructors_ability_to_stimulate"),
			y7 = chart.addMeasureAxis(y, "pace_and_speed"),
			y8 = chart.addMeasureAxis(y, "understanding"),
			y9 = chart.addMeasureAxis(y, "recall_information_from_previous_class");

	// look pretty
		x.outputFormat = "%m/%d";
		x.title = "Date";
		y.title = "Quantitative Questions";

	
	//Add all the series you want! These get added to the chart in this order. (i.e. chart[0] is the "Quality" line, chart[1] is the "Difficulty" line etc)
		chart.addSeries(["Quality"], dimple.plot.line, [x, y3]).aggregate = dimple.aggregateMethod.avg;
		chart.addSeries(["Difficulty"], dimple.plot.line, [x, y4]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Communication"], dimple.plot.line, [x, y5]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Interest"], dimple.plot.line, [x, y6]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Speed"], dimple.plot.line, [x, y7]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Understanding"], dimple.plot.line, [x, y8]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Recall"], dimple.plot.line, [x, y9]).aggregate = dimple.aggregateMethod.avg;

	//add a legend
	var legend = chart.addLegend("70%", "60%", 0, 200);
	
	chart.draw();
	
	
	//----------------------------------------------------
	// Below section for toggling series on the chart
	
	// How this works: toggleIdxs is a bool[] for knowing which chart.series is on/off by series index (series get added in order of chart.addSeries in the section above). toggleOn is the name of the series ("Quality"), grabbed from the name of the legend item (aggField slice) and matches with the appropriate series index using categoryNames[].
	var toggleIdxs = [0,0,0,0,0,0,0], //7 of them
	 	toggleOn = [],
	 	categoryNames = ["Quality", "Difficulty", "Communication", "Interest", "Speed", "Understading", "Recall"];
	
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
	
	
	
	//----------------------------------------------------
	
	
	//Below is the section for the time range scrolling
	
	//using d3.slider, created by benheb.github.io/d3.slider/
	d3.select('#slider1').call(d3.slider());
	
	
}


var start = new Date();
var end = new Date();


function startRange(form) {
	var startDate = new Date(form.startDate.value);
	var startDateUTC = Date.parse(startDate);
	x.overrideMin = startDateUTC;
	chart.draw(0, true);
	
	// Get completion/accuracy data
/*	$.ajax({
		url: "/exit_tickets/report",
		data: { start_date: start,
				end_date: end },
		type="GET",
		success: function(response) {
			console.log(response); }
		   });
*/	
}	


function endRange(form) {
	var endDate = new Date(form.endDate.value);
	var endDateUTC = Date.parse(endDate);
	x.overrideMax = endDateUTC;
	chart.draw(0,true);
	

}