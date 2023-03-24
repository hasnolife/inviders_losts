// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';
import 'package:inviders_losts/entity/entity.dart';

import 'package:inviders_losts/resourses/consts.dart';

class ApiClient {
  final _client = HttpClient();

  Future<TodayDataModel> getData() async {
    final request = await _client.getUrl(Uri.parse(Configuration.url));

    final response = await request.close();

    final List<OneCardViewModel> cardData = [];
      final responseList = await response.transform(utf8.decoder).toList();
      final httpDocument = responseList.join();
      final document = parse(httpDocument).body;
      final headline = document!.getElementsByClassName('headline')[0];
      final todayDate = document.getElementsByClassName('black')[0];

      // print(headline.text);
      // print(todayDate.text);

      for (var i = 0; i < 13; i++) {
        final cardString = document
            .getElementsByClassName('casualties')[0]
            .children[0]
            .children[0]
            .children[i]
            .text;
        cardData.add(_stringDivider(cardString));
      }

      return TodayDataModel(
          headline: headline.text, todayData: todayDate.text, data: cardData);

  }


// parse string and return data class
  OneCardViewModel _stringDivider(String cardString) {
    final cardStringsList = cardString.split('— ');
    final title = cardStringsList[0];
    final lost = cardStringsList[1].split('(');

    var losts = lost[0];
    final splitLosts = losts.split(' ');
    if (splitLosts.length > 2) {
      losts = splitLosts[1];
    }
    late final String lostYesterday;
    if (lost.length > 1) {
      lostYesterday = lost[1].split(')')[0];
    } else {
      lostYesterday = '';
    }

    return OneCardViewModel(
      icon: null,
      title: title,
      losts: losts,
      lostYesterday: lostYesterday,
    );
  }
}
