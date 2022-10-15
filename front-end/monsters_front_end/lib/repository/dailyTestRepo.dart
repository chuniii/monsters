// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../API/dailyTestAPI.dart';

class DailyTestRepository implements DailyTestApiDataSource {
  final client = http.Client();
  final String domain = "http://10.0.2.2:8080";
  @override
  Future<Map<String, dynamic>> searchDailyTest() {
    return _getDailyTest(Uri.parse('$domain/dailyTest/search'));
  }

  Future<Map<String, dynamic>> _getDailyTest(Uri url) async {
    final request =
        await client.get(url, headers: {'Content-type': 'application/json'});
    if (request.statusCode == 200) {
      Map<String, dynamic> dailyTest = jsonDecode(request.body);
      return Future.value(dailyTest);
    } else {
      Map<String, dynamic> dailyTest = jsonDecode(request.body);
      return dailyTest;
    }
  }

}