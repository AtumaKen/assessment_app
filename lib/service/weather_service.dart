import 'dart:convert';

import 'package:assessment_app/model/coordinates_model.dart';
import 'package:assessment_app/model/weather_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherService {
  Future<WeatherDetailModel> getWeatherReport(latitude, longitude) async {
    final url =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude={part}&appid=e0d060ad03dc82dcd4a796b25b4557af" +
            "&units=metric";

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) return null;
      final WeatherDetailModel weatherDetailModel = WeatherDetailModel(
          minTemp: extractedData["daily"]["temp"]["min"],
          maxTemp: extractedData["daily"]["temp"]["max"],
          cloudPercentage: extractedData["daily"]["clouds"],
          humidity: extractedData["daily"]["humidity"],
          date: DateFormat("yyyy-MM-dd HH:mm:ss")
              .parse(extractedData["daily"]["dt"], true)
              .toLocal(),
          coordinatesModel: CoordinatesModel(
              long: extractedData["long"], lat: extractedData["lat"]));
      return weatherDetailModel;
    } catch (error) {
      throw (error);
    }
  }
}
