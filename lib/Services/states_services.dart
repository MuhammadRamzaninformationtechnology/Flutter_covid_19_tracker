import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker/Models/WorldStatesModels.dart';
import 'package:flutter_covid_19_tracker/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModels> fecthWorldStatesRecords () async {
    final response = await http.get(Uri.parse(AppUrl.worldstatusapi));
    if (response.statusCode == 200) {
    var data= jsonDecode(response.body);
    return WorldStatesModels.fromJson(data);

    }
    else {
      throw('error');
    }
  }
  Future<List<dynamic>> countriesListApi () async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countries));
    if (response.statusCode == 200) {
      data= jsonDecode(response.body);
      return data;

    }
    else {
      throw('error');
    }
  }
}
