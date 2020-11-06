import 'package:assessment_app/model/coordinates_model.dart';
import 'package:flutter/cupertino.dart';

class WeatherDetailModel{
  final String minTemp;
  final String maxTemp;
  final String cloudPercentage;
  final String humidity;
  final DateTime date;
  final CoordinatesModel coordinatesModel;

  WeatherDetailModel({
    @required this.minTemp,
    @required this.maxTemp,
    @required this.cloudPercentage,
    @required this.humidity,
    @required this.date,
    this.coordinatesModel
});
}