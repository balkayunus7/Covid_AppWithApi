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

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: const TextStyle(color: Colors.white, fontSize: 30),
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
                    child: Column(
                      children: [
                        ReusableRow(
                            title: 'Cases',
                            value: widget.totalCases.toString()),
                        ReusableRow(
                            title: 'Active', value: widget.active.toString()),
                        ReusableRow(
                            title: 'TodayRecovered',
                            value: widget.todayRecovered.toString()),
                        ReusableRow(
                            title: 'TotalRecovered',
                            value: widget.totalRecovered.toString()),
                        ReusableRow(
                            title: 'TotalDeaths',
                            value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: 'Cricital',
                            value: widget.critical.toString()),
                        ReusableRow(
                            title: 'Contitent', value: widget.contitent),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 70,
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
