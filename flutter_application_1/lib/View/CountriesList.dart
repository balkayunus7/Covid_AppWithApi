// ignore_for_file: file_names
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'DeatilsScreen.dart';
import 'package:flutter_application_1/Service/Utilitiy/StateServices.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    _Utilities utilities = _Utilities();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: utilities.allPad,
              // * TextformField added for searchBar
              child: TextFormField(
                onChanged: (value) => setState(() {}),
                controller: searchController,
                decoration: textFormDec(
                    hintText: utilities.hintText,
                    symetricPad: utilities.symetricPad),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: stateServices.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                //*  if data is empty get shimmer
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ShimmerWidget(
                        contColor: utilities.shimmerCol,
                        contJeight: utilities.contJeight,
                        contWidth: utilities.contWidth,
                        leadHeight: utilities.leadHeight,
                      );
                    },
                  );
                }
                // * if data is not empty get service requests
                else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]["country"];

                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                                // * if searchBar text is empty get ListTile(country names and flag )
                                onTap: () {
                                  var materialPageRoute = MaterialPageRoute(
                                      builder: (context) =>
                                          detaRoutService(snapshot, index));
                                  Navigator.push(context, materialPageRoute);
                                },
                                child: baseListtile(snapshot, index)),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        // * if searchBar is used show wanted csountry
                        return Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  var materialPageRoute = MaterialPageRoute(
                                      builder: (context) =>
                                          detaRoutService(snapshot, index));
                                  Navigator.push(context, materialPageRoute);
                                },
                                child: baseListtile(snapshot, index)),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  // * textFormInput Inputdecoration
  InputDecoration textFormDec(
      {required final String? hintText,
      required final EdgeInsets symetricPad}) {
    return InputDecoration(
        hintText: hintText,
        contentPadding: symetricPad,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)));
  }

  // * get base ListTile for each Country
  ListTile baseListtile(AsyncSnapshot<List<dynamic>> snapshot, int index) {
    return ListTile(
      title: Text(snapshot.data![index]["country"]),
      subtitle: Text(snapshot.data![index]["cases"].toString()),
      leading: Image(
        height: 50,
        width: 50,
        image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"]),
      ),
    );
  }

  // * Material PageRouter
  DetailsScreen detaRoutService(
      AsyncSnapshot<List<dynamic>> snapshot, int index) {
    return DetailsScreen(
      contitent: snapshot.data![index]["continent"],
      name: snapshot.data![index]["country"],
      image: snapshot.data![index]["countryInfo"]["flag"],
      active: snapshot.data![index]["active"],
      critical: snapshot.data![index]["critical"],
      test: snapshot.data![index]["tests"],
      todayRecovered: snapshot.data![index]["todayRecovered"],
      totalCases: snapshot.data![index]["cases"],
      totalDeaths: snapshot.data![index]["deaths"],
      totalRecovered: snapshot.data![index]["recovered"],
    );
  }
}

// * Shimmer
class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.leadHeight,
    required this.contJeight,
    required this.contWidth,
    required this.contColor,
  });

  final double leadHeight;
  final double contJeight;
  final double contWidth;
  final Color contColor;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          ListTile(
            title: Container(
              height: contJeight,
              width: contWidth,
              color: contColor,
            ),
            subtitle: Container(
              height: contJeight,
              width: contWidth,
              color: contColor,
            ),
            leading: Container(
              height: leadHeight,
              width: contWidth,
              color: contColor,
            ),
          )
        ],
      ),
    );
  }
}

// * used for this view
class _Utilities {
  final String hintText = "Search a Country";
  final EdgeInsets symetricPad = const EdgeInsets.symmetric(horizontal: 20);
  final EdgeInsets allPad = const EdgeInsets.all(10.0);
  final Color shimmerCol = Colors.white;
  final double contJeight = 10;
  final double contWidth = 89;
  final double leadHeight = 50;
}
