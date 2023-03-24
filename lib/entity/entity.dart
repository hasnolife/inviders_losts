// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TodayDataModel extends Equatable {
  final String headline;
  final String todayData;
  final List<dynamic> data;

  const TodayDataModel({
    required this.headline,
    required this.todayData,
    required this.data,
  });

  @override
  List<Object> get props => [headline, todayData, data];

}

class OneCardViewModel extends Equatable {
  final Icon? icon;
  final String title;
  final String losts;
  final String lostYesterday;

  const OneCardViewModel({
    required this.icon,
    required this.title,
    required this.losts,
    required this.lostYesterday,
  });

  @override
  List<Object?> get props => [icon, title, losts, lostYesterday];
}
