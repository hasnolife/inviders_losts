// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';

import 'package:inviders_losts/resourses/consts.dart';

class TodayData {
  String? headline;
  String? todayDate;
  List<dynamic>? data;
  TodayData({
    required this.headline,
    required this.todayDate,
    required this.data,
  });
}

class ApiClient {
  final _client = HttpClient();

  Future<TodayData> getData() async {
    final request = await _client.getUrl(Uri.parse(url));

    final response = await request.close();

    final List<dynamic> data = [];
    if (response.statusCode == 200) {
      final responseList = await response.transform(utf8.decoder).toList();
      final httpDocument = responseList.join();
      final document = parse(httpDocument).body;
      final headline = document?.getElementsByClassName('headline')[0];
      final todayDate = document?.getElementsByClassName('black')[0];

      // print(headline.text);
      // print(todayDate.text);

      for (var i = 0; i < 13; i++) {
        data.add(document
            ?.getElementsByClassName('casualties')[0]
            .children[0]
            .children[0]
            .children[i]
            .text);
      }

      return TodayData(
          headline: headline?.text, todayDate: todayDate?.text, data: data);
    } else {
      throw Exception('Error');
    }
  }
}
