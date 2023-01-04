// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/WorldStatesModel.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_application_1/Service/Utilitiy/StateServices.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'CountriesList.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  // ? Fix it this shimmer colors
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    _Utilities utilities = _Utilities();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
              future: stateServices.fetchWorldStateRecords(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  // * if data is empty show loading circle or spinkit
                  return Expanded(
                      flex: 1,
                      child: SpinkitWidget(
                        controller: _controller,
                        colorSpin: Colors.white,
                        spinSize: 50,
                      ));
                } else {
                  return Column(
                    children: [
                      // *Piechart added with animations
                      PieChart(
                        dataMap: {
                          utilities.pieTot:
                              double.parse(snapshot.data!.cases!.toString()),
                          utilities.pieRec: double.parse(
                              snapshot.data!.recovered!.toString()),
                          utilities.pieDeath:
                              double.parse(snapshot.data!.deaths!.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        chartType: ChartType.ring,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06),
                        child: Card(
                          // * Card for ReusableRows
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: utilities.serviceCase,
                                  value: snapshot.data!.cases!.toString()),
                              ReusableRow(
                                  title: utilities.serviceTotDeath,
                                  value: snapshot.data!.deaths!.toString()),
                              ReusableRow(
                                  title: utilities.serviceTotRec,
                                  value: snapshot.data!.recovered!.toString()),
                              ReusableRow(
                                  title: utilities.serviceActive,
                                  value: snapshot.data!.active!.toString()),
                              ReusableRow(
                                  title: utilities.serviceCrit,
                                  value: snapshot.data!.critical!.toString()),
                              ReusableRow(
                                  title: utilities.serviceTodDeath,
                                  value:
                                      snapshot.data!.todayDeaths!.toString()),
                              ReusableRow(
                                  title: utilities.serviceTodRec,
                                  value: snapshot.data!.todayRecovered!
                                      .toString()),
                            ],
                          ),
                        ),
                      ),
                      // * added GestureDetector for PageRoueter
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CountriesListScreen(),
                              ));
                        },
                        child: Container(
                            height: utilities.butContHeight,
                            decoration: BoxDecoration(
                                color: utilities.buttonColor,
                                borderRadius: utilities.buttonRad),
                            child: Center(
                              child: Text(
                                utilities.buttonText,
                                // ?  replace  this style with theme
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )
                    ],
                  );
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}

// * Spinkit Widget for Loading Scene
class SpinkitWidget extends StatelessWidget {
  const SpinkitWidget({
    super.key,
    required AnimationController controller,
    required this.colorSpin,
    required this.spinSize,
  }) : _controller = controller;

  final AnimationController _controller;
  final Color colorSpin;
  final double spinSize;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: colorSpin,
      size: spinSize,
      controller: _controller,
    );
  }
}

// * ReusableRow to show data
class ReusableRow extends StatelessWidget {
  const ReusableRow({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}

// * Basic Utilities
class _Utilities {
  final String serviceCase = 'Cases';
  final String serviceActive = 'Active';
  final String serviceTodRec = 'Today Recovered';
  final String serviceTotRec = 'Total Recovered';
  final String serviceTodDeath = "Today Death";
  final String serviceTotDeath = " Total Death";
  final String serviceCrit = 'Critical';
  final String pieTot = "Total";
  final String pieRec = "Recovered";
  final String pieDeath = "Death";
  final String serviceCont = 'Continant';
  final String buttonText = "Track Countries";
  final Color buttonColor = const Color(0xff1aa260);
  final BorderRadius buttonRad = BorderRadius.circular(10);
  final double butContHeight = 50;
}
