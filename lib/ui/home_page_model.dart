
import 'package:flutter/material.dart';
import 'package:inviders_losts/api_client/api_client.dart';
import 'package:inviders_losts/entity.dart';

class HomePageModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late final Future<TodayData> _futureData;
  get futureData => _futureData;
  late final TodayData _data;
  get data => _data;

  HomePageModel() {
    _setup();
  }

  Future<void> onRefresh() async {
    _futureData = _apiClient.getData();
    notifyListeners();
  }

  void _setup() {
   _futureData = _apiClient.getData().then((data) => _data=data);
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

}