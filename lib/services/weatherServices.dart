import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml2json/xml2json.dart';

class XmlToJsonService {
  final Xml2Json xml2json = Xml2Json();
  final String apiUrl =
      'https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-KepulauanRiau.xml';

  Future<Map<String, dynamic>> fetchAndConvertXmlToJson() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsonString = xml2json.toParker();
      var jsonData = json.decode(jsonString);

      if (jsonData.containsKey('data') &&
          jsonData['data'].containsKey('forecast') &&
          jsonData['data']['forecast'].containsKey('area')) {
        return jsonData;
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load XML data');
    }
  }

    Future<Map<String, dynamic>> fetchWeatherForecast() async {
    final jsonData = await fetchAndConvertXmlToJson();
    final DateTime now = DateTime.now();
    final DateFormat dateFormat = DateFormat('yyyyMMddTHHmm');

    final Map<String, dynamic> forecastMap = {
      'today': {},
      'hourly': [],
      'nextDays': []
    };

    if (jsonData['data']['forecast']['area'] is List) {
      var areaList = jsonData['data']['forecast']['area'];

      for (var area in areaList) {
        var forecastDates = area['parameter'][1]['timerange'];
        for (var date in forecastDates) {
          DateTime forecastDate = dateFormat.parse(date['@datetime']);
          var temperature = area['parameter'][5]['timerange'][0]['value'][0];
          var weatherCode = area['parameter'][6]['timerange'][0]['value'][1];

          if (temperature != null && weatherCode != null) {
            if (forecastDate.day == now.day &&
                forecastDate.month == now.month &&
                forecastDate.year == now.year) {
              // Data for today
              forecastMap['today'] = {
                'temperature': temperature.toString(),
                'weatherCode': weatherCode.toString(),
              };
            } else if (forecastDate.isAfter(now) &&
                forecastDate.isBefore(now.add(Duration(days: 1)))) {
              // Hourly data for today
              forecastMap['hourly'].add({
                'time': DateFormat('HH:mm').format(forecastDate),
                'value': temperature.toString(),
                'weatherCode': weatherCode.toString(),
              });
            } else if (forecastDate.isAfter(now.add(Duration(days: 1))) &&
                forecastDate.isBefore(now.add(Duration(days: 4)))) {
              // Next 3 days data
              forecastMap['nextDays'].add({
                'day': DateFormat('EEEE').format(forecastDate),
                'date': DateFormat('dd MMM yyyy').format(forecastDate),
                'temperature': temperature.toString(),
                'weatherCode': weatherCode.toString(),
              });
            }
          }
        }
      }
    } else {
      throw Exception('Unexpected JSON structure');
    }
    return forecastMap;
  }
}
