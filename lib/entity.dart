// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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

class OneCardData {
  Icon? icon;
  String title;
  String losts;
  String lostYesterday = '';
  OneCardData({
    required this.icon,
    required this.title,
    required this.losts,
    required this.lostYesterday,
  });
}
