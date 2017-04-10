<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<html>
<head>
<meta charset="utf-8">
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
<meta name="title" content="">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="description" content="">
<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico">
<link rel="stylesheet" href="/css/jquery-ui.css" media="all">
<link rel="stylesheet" href="/css/wCommon.css" media="all">
<link href="http://bluemembers.hyundai.com/oc/hindex.jsp"
	rel="canonical" />
<link href="http://bluemembers.hyundai.com/oc/hindex.jsp"
	rel="alternate" hreflang="ko" />
<link rel="stylesheet" type="text/css"
	href="http://bluemembers.hyundai.com/oc/hmcss/style.css" />
<link rel="stylesheet" type="text/css"
	href="http://bluemembers.hyundai.com/oc/hmcss/calendar.css" />
<link rel="shortcut icon" type="image/x-icon"
	href="http://bluemembers.hyundai.com/oc/hmimages/BLUEmembers.ico" />
<link rel="apple-touch-icon"
	href="http://bluemembers.hyundai.com/oc/hmimages/hdr/h1_bluememebers.gif" />
<script type="text/javascript"
	src="http://bluemembers.hyundai.com/oc/hmjs/jquery.js"></script>
<script type="text/javascript"
	src="http://bluemembers.hyundai.com/oc/hmjs/jquery.alphanumeric.js"></script>
<script type="text/javascript"
	src="http://bluemembers.hyundai.com/oc/hmjs/common/common.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://bluemembers.hyundai.com/oc/hmcss/main.css" />
<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/common.ui.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="https://code.jquery.com/jquery-1.8.2.min.js"></script>
<script src="https://cdn.oesmith.co.uk/morris-0.4.1.min.js"></script>
<script src="https://d3js.org/d3.v4.js"></script>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</head>
<style>
h3.title {
	color: #4178be;
	font-family: "HelveticaNeue-Light", "Helvetica Neue Light",
		"Helvetica Neue", "HelvNeueLightforIBM", Arial, sans-serif;
	margin-left: 20px;
	margin-top: 10px;
}

div {
	font-family: "HelveticaNeue-Light", "Helvetica Neue Light",
		"Helvetica Neue", "HelvNeueLightforIBM", Arial, sans-serif;
}
</style>
<%
	Gson gsonObj = new Gson();
	Map<Object,Object> map = null;
	List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
	
	map = new HashMap<Object,Object>(); map.put("x", 10); map.put("y", 71); list.add(map);
	map = new HashMap<Object,Object>(); map.put("x", 20);  map.put("y", 55); list.add(map);
	map = new HashMap<Object,Object>(); map.put("x", 30);  map.put("y", 50); list.add(map);
	map = new HashMap<Object,Object>(); map.put("x", 40);  map.put("y", 65); list.add(map);
	map = new HashMap<Object,Object>(); map.put("x", 50);  map.put("y", 95); list.add(map);
	map = new HashMap<Object,Object>(); map.put("x", 60);  map.put("y", 68); list.add(map);
	map = new HashMap<Object,Object>(); map.put("x", 70);  map.put("y", 28); list.add(map);
	map = new HashMap<Object,Object>(); map.put("x", 80);  map.put("y", 34); list.add(map);
	map = new HashMap<Object,Object>(); map.put("x", 90);  map.put("y", 14); list.add(map);	
	String dataPoints = gsonObj.toJson(list);
	%>
<script type="text/javascript">
	jQuery(document).ready(function($) {

		Morris.Bar({
			element : 'bar-example',
			data : [ {
				y : '1min',
				a : 380
			}, {
				y : '3min',
				a : 100
			}, {
				y : '5min',
				a : 20
			}, {
				y : '10min',
				a : 0
			} ],
			xkey : 'y',
			ykeys : [ 'a' ],
			labels : [ 'Count' ]
		});
		Morris.Donut({
			element : 'donut-example1',
			data : [ {
				label : "Pass",
				value : 96
			}, {
				label : "Fail",
				value : 4
			} ]
		});

		Morris.Donut({
			element : 'donut-example2',
			data : [ {
				label : "Pass",
				value : 70
			}, {
				label : "Fail",
				value : 30
			} ]
		});

	});
	
	window.onload = function () {
		var chart = new CanvasJS.Chart("chartContainer1",
		{
			title:{
				text: "Real Time"
			},     
	                animationEnabled: true,     
			data: [
			{        
				type: "doughnut",
				startAngle: 60,                          
				toolTipContent: "{legendText}: {y} - <strong>#percent% </strong>", 					
				showInLegend: true,
				dataPoints: [
					{y: 480, indexLabel: "Pass #percent%", legendText: "Pass" },
					{y: 20, indexLabel: "Fail #percent%", legendText: "Fail" }		
				]
			}
			]
		});
		chart.render();
		
		var chart = new CanvasJS.Chart("chartContainer2",
				{
					title:{
						text: "Total"
					},     
			                animationEnabled: true,     
					data: [
					{        
						type: "doughnut",
						startAngle: 60,                          
						toolTipContent: "{legendText}: {y} - <strong>#percent% </strong>", 					
						showInLegend: true,
						dataPoints: [
							{y: 4900, indexLabel: "Pass #percent%", legendText: "Pass" },
							{y: 100, indexLabel: "Fail #percent%", legendText: "Fail" }		
						]
					}
					]
				});
		
				chart.render();	
				
				var chart = new CanvasJS.Chart("chartContainer", {

						title:{
							text:"Communication Time"				

						},
			                        animationEnabled: true,
						axisX:{
							interval: 1,
							gridThickness: 0,
							labelFontSize: 10,
							labelFontStyle: "normal",
							labelFontWeight: "normal",
							labelFontFamily: "Lucida Sans Unicode"

						},
						axisY2:{
							interlacedColor: "rgba(1,77,101,.2)",
							gridColor: "rgba(1,77,101,.1)"

						},

						data: [
						{     
							type: "bar",
			                name: "companies",
							axisYType: "secondary",
							color: "#014D65",				
							dataPoints: [
												
							{y: 20, label: "5min"  },
							{y: 100, label: "3min"  },
							{y: 380, label: "1min"  }
							]
						}
						
						]
					});

			chart.render();
		}
	
</script>
<body>
	<div class="mp-wrap">
		<div class="mp-header">
			<div class="mp-gnb">
				<input type="image" src='/img/header.png'
					style="width: 100%; height: 35px;">
			</div>
			<!-- //mp-gnb -->
		</div>
		<!-- //mp-header -->
		<div style="width: 100%; height: 100%;">
			<div style="width: 100%; height: 10px"></div>
			<div
				style="width: 98%; height: 315px; display: inline-block; margin-left: 10px">
				<div
					style="width: 50%; height: 315px; margin: 0;border: 1px solid #e8e8e8; border-radius: 10px; display: inline-block;">
					<h3 class="title">HYUNDAI WPC Record</h3>
					<div style="width: 40%; margin-left: 7%; display: inline-block">
						<div id="chartContainer1" style="height: 200px"></div>
						<table style="width: 100%; text-align: center">
							<tr>
								<td style="text-decoration: underline">CALL</td>
								<td style="text-decoration: underline">PASS</td>
								<td style="text-decoration: underline">FAIL</td>
							<tr>
							<tr>
								<td>500</td>
								<td>280</td>
								<td><a href="../">20</a></td>
							<tr>
						</table>
					</div>
					<div style="width: 40%; margin-left: 7%; display: inline-block">
						<div id="chartContainer2" style="height: 200px"></div>
						<table style="width: 100%; text-align: center">
							<tr>
								<td style="text-decoration: underline">CALL</td>
								<td style="text-decoration: underline">PASS</td>
								<td style="text-decoration: underline">FAIL</td>
							<tr>
							<tr>
								<td>5,000</td>
								<td>4,900</td>
								<td><a href="../">100</a></td>
							<tr>
						</table>
					</div>
				</div>
				<div style="width: 49%; height: 315px; border: 1px solid #e8e8e8; border-radius: 10px; float: right">
					<table style="width: 100%">
						<tr style="height: 45px;">
							<td colspan=4
								style="text-align: center; border-bottom: solid 1px #e8e8e8"><h3
									class="title">Failure List</h3></td>
							<td style="text-align: center; border-bottom: solid 1px #e8e8e8"><h3
									class="title">Re-Training</h3></td>
						</tr>
						<tr style="height: 45px">
							<td style="text-align: center">Log001</td>
							<td>질문인식불가</td>
							<td style="text-align: center">홍길동</td>
							<td style="text-align: center">2017-04-07</td>
							<td style="text-align: center"><img alt=""
								src="/img/Picture1.png" /></td>
						</tr>
						<tr style="height: 45px">
							<td style="text-align: center">Log002</td>
							<td>돌발사항</td>
							<td style="text-align: center">신규고객</td>
							<td style="text-align: center">2017-04-07</td>
							<td style="text-align: center"><img alt=""
								src="/img/Picture1.png" /></td>
						</tr>
						<tr style="height: 45px">
							<td style="text-align: center">Log003</td>
							<td>고객강제종료</td>
							<td style="text-align: center">박신혜</td>
							<td style="text-align: center">2017-04-07</td>
							<td style="text-align: center"><img alt=""
								src="/img/Picture1.png" /></td>
						</tr>
						<tr style="height: 45px">
							<td style="text-align: center">Log004</td>
							<td>질문인식불가</td>
							<td style="text-align: center">신규고객</td>
							<td style="text-align: center">2017-04-07</td>
							<td style="text-align: center">처리중</td>
						</tr>
						<tr style="height: 45px">
							<td style="text-align: center">Log005</td>
							<td>질문인식불가</td>
							<td style="text-align: center">신규고객</td>
							<td style="text-align: center">2017-04-07</td>
							<td style="text-align: center">처리중</td>
						</tr>
						<tr style="height: 45px">
							<td style="text-align: center">Log006</td>
							<td>고객강제종료</td>
							<td style="text-align: center">신규고객</td>
							<td style="text-align: center">2017-04-07</td>
							<td style="text-align: center">처리중</td>
						</tr>
					</table>
				</div>
			</div>
			<div
				style="width: 98%; height: 300px; display: inline-block; margin-top: 10px; margin-bottom: 30px;margin-left:10px;">
				<div style="width:50%; height: 100%; display: inline-block;
				border: 1px solid #e8e8e8; border-radius: 10px;">
					<div id="chartContainer" style="height: 300px; width: 98%;">
					</div>
				</div>
				<div style="width: 49%; height: 100%;border: 1px solid #e8e8e8; border-radius: 10px; float:right">
					<table style="width: 100%;text-align: center;">
						<tr style="height: 45px;">
							<td style="border-bottom: solid 1px #e8e8e8"><h3 class="title">Keyword</h3></td>
							<td style="border-bottom: solid 1px #e8e8e8; border-right: solid 1px #e8e8e8"><h3 class="title">Count</h3></td>
						</tr>
						<tr>
							<td>Price</td>
							<td style="border-right: solid 1px #e8e8e8">13</td>
							<td rowspan=4><img alt=""
								src="/img/communication.PNG" /></td>
						</tr>
						<tr>
							<td>E-Catalog</td>
							<td style="border-right: solid 1px #e8e8e8">2</td>
							<td></td>
						</tr>
						<tr>
							<td>Connect with Dealer</td>
							<td style="border-right: solid 1px #e8e8e8">3</td>
							<td></td>
						</tr>
						<tr>
							<td>Others</td>
							<td style="border-right: solid 1px #e8e8e8">5</td>
							<td></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>