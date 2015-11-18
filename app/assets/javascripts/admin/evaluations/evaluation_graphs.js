$.ajax({
  url: "/api/v1/evaluations",
  type: "GET",
  dataType: 'json',
  response: "{}",
  success: function(response) {
    var titles = getTitles(response); 
    console.log(titles);
    createGraph(response);
  },

  error: function(error) {
    console.log(error);
  }
})

function getTitles(data) {
  titles = [];
  for(var key in JSON.parse(data[0].json_scores)) {
    titles.push(key);
  }
  return titles;
}

function createGraph(data) {
  var vis = d3.select("#visualisation"),
              WIDTH = screen.width/2 - 50,
              HEIGHT = 500,
              MARGINS = {
                  top: 20,
                  right: 20,
                  bottom: 20,
                  left: 50
              },
              xScale = d3.scale.linear().range([MARGINS.left, WIDTH - MARGINS.right]).domain([0, 5]),
              yScale = d3.scale.linear().range([HEIGHT - MARGINS.top, MARGINS.bottom]).domain([0,5]),
  xAxis = d3.svg.axis()
      .scale(xScale),
      yAxis = d3.svg.axis()
      .scale(yScale)
      .orient("left");   

  vis.append("svg:g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + (HEIGHT - MARGINS.bottom) + ")")
      .call(xAxis);
  vis.append("svg:g")
      .attr("class", "y axis")
      .attr("transform", "translate(" + (MARGINS.left) + ",0)")
      .call(yAxis);
}

