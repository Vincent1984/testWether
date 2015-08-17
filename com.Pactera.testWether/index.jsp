<html>
  <head>
    <script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript'>
     google.load('visualization', '1', {'packages': ['geochart']});
     google.setOnLoadCallback(drawMarkersMap);
	 var CityArr = ["Sydney","Melbourne","Wollongong"];
    function drawMarkersMap() {
		var charArr = [];
		charArr.push(new Array("City"));
		for(var i=0;i<CityArr.length;i++){
			charArr.push(new Array(CityArr[i]));
		}
/**     
	 var data = google.visualization.arrayToDataTable([
        ['City'],
        ['Sydney'],
        ['Melbourne'],
		['Wollongong']
      ]);
*/
	 var data = google.visualization.arrayToDataTable(charArr);

      var options = {
        region: 'AU',
        displayMode: 'markers',
        colorAxis: {colors: ['green', 'blue']},
      };

      var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
		chart.draw(data, options);
		google.visualization.events.addListener(chart, 'select', selectHandler);
		
		function selectHandler(){
		  var selection = chart.getSelection();
		  var citySelect = selection[0].row;
		  console.log(CityArr[citySelect]);
		  showHint(CityArr[citySelect]);
		  //selection[0].row
		 
		}

	  };
	  
	  var xmlHttp

	function showHint(str)
	{

	  if (str.length==0)
		{
		document.getElementById("WetherReport").innerHTML="";
		return;
		}

	  xmlHttp=GetXmlHttpObject()

	  if (xmlHttp==null)
		{
		alert ("not Support AJAX");
		return;
		}
	  var url="ServletDemo";
	  url=url+"?city="+str;
	  url=url+"&sid="+Math.random();
	  xmlHttp.onreadystatechange=stateChanged;
	  xmlHttp.open("GET",url,true);
	  xmlHttp.send(null);
	}

	function stateChanged() 
	{ 
	if (xmlHttp.readyState==4)
	{ 
	var resp = eval("(" +xmlHttp.responseText+")");
	var wetherService = resp["HeWeather data service 3.0"];
	if (wetherService[0].status=="ok"){
		var basic = wetherService[0].basic;
		var Wnow = wetherService[0].now;
		var currentCity = basic.city;
		var currentTime = basic.update.loc;
		var currentWether = Wnow.cond.txt;
		var currentTem = Wnow.tmp;
		var currentWind = Wnow.wind.spd;
		document.getElementById("currentCity").innerHTML = currentCity;
		document.getElementById("currentUpdate").innerHTML = currentTime;
		document.getElementById("currentWether").innerHTML = currentWether;
		document.getElementById("currentTem").innerHTML = currentTem+"℃";
		document.getElementById("currentWind").innerHTML = currentWind+"kn/h";

		//console.log(wetherService[0].basic.city);
	}
	//var city = resp[0].statu
	//console.log(typeof resp);
	//console.log(resp["HeWeather data service 3.0"].length)
	//document.getElementById("WetherReport").innerHTML=xmlHttp.responseText;
	}
	}

	function GetXmlHttpObject()
	{
	  var xmlHttp=null;
	  try
		{
		// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
		}
	  catch (e)
		{
		// Internet Explorer
		try
		  {
		  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		  }
		catch (e)
		  {
		  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		}
	return xmlHttp;
	}

    </script>
  </head>
  <body>
    <div id="chart_div" style="width: 900px; height: 500px;"></div>
	<div id="WetherReport">
		<table>
			<tr>
				<td>City</td>
				<td id="currentCity"><td>
			</tr>
			<tr>
				<td>Updated time</td>
				<td id="currentUpdate"><td>
			</tr>
			<tr>
				<td>Wether</td>
				<td id="currentWether"><td>
			</tr>
			<tr>
				<td>Temperature</td>
				<td id="currentTem"><td>
			</tr>
			<tr>
				<td>Wind</td>
				<td id="currentWind"><td>
			</tr>
		</table>
	</div>
  </body>
</html>
