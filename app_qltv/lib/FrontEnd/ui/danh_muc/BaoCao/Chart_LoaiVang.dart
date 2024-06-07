import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartDialog extends StatefulWidget {
  final Map<String, double> percentage;

  const PieChartDialog(this.percentage, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartDialogState();
}

class PieChartDialogState extends State<PieChartDialog> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: ListView(
                children: widget.percentage.entries.map((entry) {
                  int index =
                      widget.percentage.keys.toList().indexOf(entry.key);
                  return ListTile(
                    title: Text(entry.key),
                    trailing: Text("${entry.value.toStringAsFixed(3)}%"),
                    textColor: _getColor(index),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    startDegreeOffset: 180,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 1,
                    centerSpaceRadius: 0,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return widget.percentage.entries.map((entry) {
      int index = widget.percentage.keys.toList().indexOf(entry.key);
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      final color = _getColor(index);

      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.value.toStringAsFixed(3)}%',
        radius: radius,
        titlePositionPercentageOffset: 1.7,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        borderSide: isTouched
            ? const BorderSide(color: Colors.black, width: 6)
            : BorderSide.none,
      );
    }).toList();
  }

  Color _getColor(int index) {
    const colors = [
      Colors.blue,
      Colors.pink,
      Colors.green,
      Colors.purple,
      Colors.orange,
    ];
    return colors[index % colors.length];
  }
}
