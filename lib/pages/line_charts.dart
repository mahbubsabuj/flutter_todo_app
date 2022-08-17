import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:todo_app/models/monthly_sales.dart';

class LineCharts extends StatelessWidget {
  const LineCharts({Key? key}) : super(key: key);
  static List<charts.Series<MonthlySales, int>> _createLineChartSample() {
    final data = [
      MonthlySales(0, 100),
      MonthlySales(1, 300),
      MonthlySales(3, 400),
      MonthlySales(4, 300),
      MonthlySales(5, 400),
      MonthlySales(6, 300),
      MonthlySales(7, 400),
      MonthlySales(8, 400),
      MonthlySales(9, 300),
      MonthlySales(10, 299),
      MonthlySales(11, 300),
    ];
    return [
      charts.Series<MonthlySales, int>(
        data: data,
        id: "Sales",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (MonthlySales sales, _) => sales.month,
        measureFn: (MonthlySales sales, _) => sales.sales,
      ),
    ];
  }

  static List<charts.Series<SalesData, String>> _createBarChartSample() {
    final data = [
      SalesData("January", 200),
      SalesData("February", 300),
      SalesData("March", 100),
      SalesData("April", 200),
      SalesData("May", 300),
      SalesData("June", 500),
      SalesData("July", 100),
      // SalesData("August", 300),
      // SalesData("September", 200),
      // SalesData("October", 800),
      // SalesData("November", 200),
      // SalesData("December", 900)
    ];
    return [
      charts.Series<SalesData, String>(
          data: data,
          id: "Sales",
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (SalesData sales, _) => sales.month,
          measureFn: (SalesData sales, _) => sales.sales),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Line Chart"),
      ),
      body: Center(
        child: ListView(children: [
          SizedBox(
          height: 200,
          child: charts.BarChart(
            _createBarChartSample(),
            animate: true,
            animationDuration: Duration(seconds: 1),
            
          ),
        ),
        SizedBox(height: 10,),
         SizedBox(
          height: 200,
          child: charts.LineChart(
            _createLineChartSample(),
            animate: true,
            animationDuration: Duration(seconds: 1),
            
          ),
        ),
        ],
      ),
    ),);
  }
}
