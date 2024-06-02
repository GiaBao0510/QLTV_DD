import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartDialog extends StatelessWidget {
  const PieChartDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: PieChartSample1(),
      ),
    );
  }
}

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State<PieChartSample1> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
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
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.blue,
              value: 25,
              title: '',
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(
                      color: Colors.white,
                      width: 6,
                    )
                  : BorderSide.none,
            );
          case 1:
            return PieChartSectionData(
              color: Colors.yellow,
              value: 25,
              title: '',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(
                      color: Colors.white,
                      width: 6,
                    )
                  : BorderSide.none,
            );
          case 2:
            return PieChartSectionData(
              color: Colors.pink,
              value: 25,
              title: '',
              radius: 60,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? BorderSide(
                      color: Colors.white,
                      width: 6,
                    )
                  : BorderSide.none,
            );
          case 3:
            return PieChartSectionData(
              color: Colors.green,
              value: 25,
              title: '',
              radius: 70,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(
                      color: Colors.white,
                      width: 6,
                    )
                  : BorderSide.none,
            );
          default:
            throw Error();
        }
      },
    );
  }
}
