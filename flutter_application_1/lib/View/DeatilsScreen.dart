// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/WorldStates.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String image;
  final String contitent;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  const DetailsScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      required this.contitent});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    _Utilities utilities = _Utilities();
    return Scaffold(
        appBar: AppBar(
          // * added Appbar Title and Texttheme
          title: Text(
            widget.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: utilities.textColor, fontSize: utilities.textSize),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .100),
                  child: Card(
                    // * Card created and service datas added this card
                    child: Column(
                      children: [
                        ReusableRow(
                            title: utilities.serviceCase,
                            value: widget.totalCases.toString()),
                        ReusableRow(
                            title: utilities.serviceActive,
                            value: widget.active.toString()),
                        ReusableRow(
                            title: utilities.serviceTodRec,
                            value: widget.todayRecovered.toString()),
                        ReusableRow(
                            title: utilities.serviceTotRec,
                            value: widget.totalRecovered.toString()),
                        ReusableRow(
                            title: utilities.serviceDeath,
                            value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: utilities.serviceCrit,
                            value: widget.critical.toString()),
                        ReusableRow(
                            title: utilities.serviceCont,
                            value: widget.contitent),
                      ],
                    ),
                  ),
                ),
                // * Every countrys flag image added in CircleAvatar
                CircleAvatar(
                  radius: utilities.avatarRad,
                  backgroundImage: NetworkImage(
                    widget.image,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

// * Basic Utilities
class _Utilities {
  final double avatarRad = 70;
  final Color textColor = Colors.white;
  final double textSize = 30;
  final String serviceCase = 'Cases';
  final String serviceActive = 'Active';
  final String serviceTodRec = 'Today Recovered';
  final String serviceTotRec = 'Total Recovered';
  final String serviceDeath = "Death";
  final String serviceCrit = 'Critical';
  final String serviceCont = 'Continant';
}
