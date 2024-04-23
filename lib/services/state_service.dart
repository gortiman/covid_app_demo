import 'dart:async';
import 'dart:convert';

import 'package:covid_tracker/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/model/worldStateModel.dart';

class StateSevices{
  Future<WorldStateModel> getWorldRecord()async{
    final response = await http.get(Uri.parse(AppUrl.baseUrl));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> getCountries () async{
    String url = "https://disease.sh/v3/covid-19/countries";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("error");
    }

  }
}
