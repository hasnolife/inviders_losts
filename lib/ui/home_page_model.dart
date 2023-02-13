import 'package:flutter/cupertino.dart';
import 'package:inviders_losts/api_client/api_client.dart';

class HomePageModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late final _futureData;
  get futureData => -_futureData;
  late final _data;
  get data => -_data;

  HomePageModel() {
    _setup();
  }

  void _setup() {
   _futureData = _apiClient.getData().then((data) => data=data);
  }

}