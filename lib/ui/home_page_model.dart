
import 'package:flutter/material.dart';
import 'package:inviders_losts/api_client/api_client.dart';
import 'package:inviders_losts/entity.dart';
import 'package:inviders_losts/ui/main_navigation.dart';

class HomePageModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late final Future<TodayData> _futureData;
  get futureData => _futureData;
  late final TodayData _data;
  get data => _data;

  HomePageModel() {
    _setup();
  }

  Future<void> onRefresh(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.homePage);
  }

  void _setup() {
   _futureData = _apiClient.getData().then((data) => _data=data);
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

}