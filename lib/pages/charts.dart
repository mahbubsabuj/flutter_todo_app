import 'package:flutter/material.dart';
import 'package:todo_app/pages/line_charts.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Charts Page"),
      ),
      body: ListView(children: [
        ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LineCharts(),),), child: const Text("Line Charts"))
      ]),
    );
  }
}
