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



// Cause sometimes people are 1000000% confident
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


// d3/dimple function that gets called in the ajax sucess
function graphData(jsonData) {
	
	
	//d3.json(jsonData, function(error, data) {
		//var filteredValues = dimple.filterData(data, "Instructor", "Amy")...nb: this is how you filter out data if you need to use it eventually...
		
		var svg = dimple.newSvg("#chart", 900, 600),
			chart = new dimple.chart(svg, jsonData);
		chart.setBounds(60,50,600,450); //play around w this
		
		var x = chart.addCategoryAxis("x", "submitted_at"),
			y = chart.addMeasureAxis("y", "certainty");
		
		x.outputFormat = "%m/%d";
		x.title = "Date";
		y.title = "Certainty";
		chart.addSeries([""], dimple.plot.line);
		chart.draw();
	//}); 
} 
