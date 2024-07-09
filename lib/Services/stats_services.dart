import 'dart:convert';

import 'package:flutter_covid_app/Model/countries_stats_model.dart';
import 'package:flutter_covid_app/Model/world_stats_model.dart';
import 'package:flutter_covid_app/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatsModel> fetchWorldStatsRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldsStatsApi));
    print(response);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      return WorldStatsModel.fromJson(body);
    } else {
      throw Exception("Invalid");
    }
  }

  Future<List<dynamic>> fetchCountriesStatsRecords() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception("Invalid");
    }
  }
}
