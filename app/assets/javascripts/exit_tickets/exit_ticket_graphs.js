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
	console.log("THERE WAS AN AJAX ERROR");
    console.log(error);
  }
})



// Clean up data; gets called in the ajax success. Then calls graphData(jsonData).
//cause sometimes people are 1000000% confident
function dataValidation(jsonData) {
	jsonData.forEach(function(j) {
		if ( parseInt(j.certainty) > 100 ) {
			console.log(j.certainty);
			j.certainty = "100";
		}
	});

	//now we can graph it
	graphData(jsonData);
}


// D3/dimple function that gets called after data validation
function graphData(jsonData) {
	
	
	//d3.json(jsonData, function(error, data) {
		//var filteredValues = dimple.filterData(data, "Instructor", "Amy")...nb: this is how you filter out data if you need to use it eventually...
		
		var svg = dimple.newSvg("#chart", 900, 600),
			chart = new dimple.chart(svg, jsonData);
		chart.setBounds(60,50,600,450); //play around w this
		
		var x = chart.addCategoryAxis("x", "submitted_at"),
			y = chart.addMeasureAxis("y", "certainty"),
			y2 = chart.addMeasureAxis(y, "score"),
			y3 = chart.addMeasureAxis(y, "overall_quality"),
			y4 = chart.addMeasureAxis(y, "difficulty"),
			y5 = chart.addMeasureAxis(y, "instructors_ability_to_communicate"),
			y6 = chart.addMeasureAxis(y, "instructors_ability_to_stimulate"),
			y7 = chart.addMeasureAxis(y, "pace_and_speed"),
			y8 = chart.addMeasureAxis(y, "understanding"),
			y9 = chart.addMeasureAxis(y, "recall_information_from_previous_class");
		
		x.outputFormat = "%m/%d";
		x.title = "Date";
		y.title = "Quantitative Questions";

		chart.addSeries(["Quality"], dimple.plot.line, [x, y3]).aggregate = dimple.aggregateMethod.avg;
		chart.addSeries(["Difficulty"], dimple.plot.line, [x, y4]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Communication"], dimple.plot.line, [x, y5]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Interest"], dimple.plot.line, [x, y6]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Speed"], dimple.plot.line, [x, y7]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Understanding"], dimple.plot.line, [x, y8]).aggregate = dimple.aggregateMethod.avg;
	chart.addSeries(["Recall"], dimple.plot.line, [x, y9]).aggregate = dimple.aggregateMethod.avg;
		
	
		chart.draw();
	//}); 
} 
