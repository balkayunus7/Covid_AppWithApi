// ignore_for_file: unused_import, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/WorldStatesModel.dart';
import 'package:http/http.dart' as http;
import 'app_url.dart';

class StateServices {
  Future<WorldStatesModel> fetchWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("error");
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("error");
    }
  }
}
