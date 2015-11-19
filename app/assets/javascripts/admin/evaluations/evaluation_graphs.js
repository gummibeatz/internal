var developers;
var data;

var colors = [
  "aqua",
  "aquamarine",
  "cornflowerblue",
  "black",
  "blue",
  "brown",
  "cadetblue",
  "chartreuse",
  "coral",
  "darkgoldenrod",
  "dimgrey",
  "forestgreen",
  "steelblue",
  "magenta",
  "midnightblue",
  "mistyrose",
  "moccasin",
  "olivedrab",
  "plum",
  "royalblue"
];

$.ajax({
  url: "/api/v1/evaluations",
  type: "GET",
  dataType: 'json',
  response: "{}",
  success: function(response) {
    var titles = getTitles(response); 
    for(var i=0; i< titles.length; i++) {
      developers = getDevelopers(response);
      assembleDeveloperData(titles[i], response); 
      createGraph(developers,titles[i],i+1);
    }
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

function getDevelopers(data) {
  devs = {};
  for(var i = 0; i < data.length; i++) {
    devs[data[i].developer_id] = [];
  }
  console.log(devs);
  return devs;
}

function assembleDeveloperData(title, response) {
  var cleanData = [];
  console.log(title);
  for(var i=0; i<response.length; i ++) {
    developers[response[i].developer_id].push({"unit": response[i].unit,
                    "score": JSON.parse(response[i].json_scores)[title]
                  });
  }
  return cleanData;
}

function createGraph(data, title, num) {
  var chart = "#chart" + num
  var vis = d3.select(chart),
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

  var lineGen = d3.svg.line()
    .x(function(d) {
      return xScale(d.unit);
    })
    .y(function(d) {
      return yScale(d.score);
    })
    .interpolate("basis");

  var titleSplit = title.split(' ');
  vis.append("text")
    .attr("x", ((WIDTH) / 2))             
    .attr("y", MARGINS.bottom )
    .attr("text-anchor", "middle")  
    .style("font-size", "16px") 
    .style("text-decoration", "underline")  
    .text(titleSplit.slice(0,titleSplit.length/2).join(' '));

  vis.append("text")
    .attr("x", ((WIDTH) / 2))             
    .attr("y", MARGINS.bottom*2 )
    .attr("text-anchor", "middle")  
    .style("font-size", "16px") 
    .style("text-decoration", "underline")  
    .text(titleSplit.slice(titleSplit.length/2,titleSplit.length).join(' '));

  var ct = -1;
  for(var developer_id in developers) {
    ct++;
    for(var i=0; i < developers[developer_id].length; i++) {
      vis.append('svg:path')
        .attr('d', lineGen(developers[developer_id]))
        .attr('stroke', colors[ct])
        .attr('stroke-width', 2)
        .attr('fill', 'none');
    }
  }

}


