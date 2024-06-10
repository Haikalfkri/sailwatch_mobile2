import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:intl/intl.dart';

class XmlToJsonService {
  final Xml2Json xml2json = Xml2Json();
  final String apiUrl =
      'https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-KepulauanRiau.xml';

  Future<Map<String, dynamic>> fetchAndConvertXmlToJson() async {
    final response = await http.get(Uri.parse(apiUrl));
    List<Map<String, dynamic>> forecastList = [];

    if (response.statusCode == 200) {
      print('Fetched XML data: ${response.body}'); // Logging XML data

      xml2json.parse(response.body);
      var jsonString = xml2json.toParker();
      print('Converted JSON string: $jsonString'); // Logging JSON string

      var jsonData = json.decode(jsonString);
      print('Parsed JSON data: $jsonData'); // Logging parsed JSON object

      if (jsonData.containsKey('data') &&
          jsonData['data'].containsKey('forecast') &&
          jsonData['data']['forecast'].containsKey('area')) {
        return jsonData;
      } else {
        print(
            'Unexpected JSON structure: $jsonData'); // Logging unexpected structure
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load XML data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchWeatherForecast() async {
    final response = await http.get(Uri.parse(apiUrl));
    final DateTime now = DateTime.now();
    final DateFormat dateFormat = DateFormat('yyyyMMddTHHmm');

    List<Map<String, dynamic>> forecastList =
        []; // Initialize with an empty list

    if (response.statusCode == 200) {
      final jsonData = _parseXmlToJson(response.body);

      if (jsonData['data']['forecast']['area'] is List) {
        var areaList = jsonData['data']['forecast']['area'] as List;

        for (var area in areaList) {
          var forecastDates = area['parameter'][1]['timerange'];
          for (var date in forecastDates) {
            DateTime forecastDate = dateFormat.parse(date['@datetime']);
            if (forecastDate.isAfter(now) &&
                forecastDate.isBefore(now.add(Duration(days: 3)))) {
              var temperatureValues =
                  area['parameter'][5]['timerange'][0]['value'];
              var weatherCodeValues =
                  area['parameter'][6]['timerange'][0]['value'];

              var temperature =
                  (temperatureValues is List && temperatureValues.isNotEmpty)
                      ? temperatureValues[0]
                      : 'N/A';
              var weatherCode =
                  (weatherCodeValues is List && weatherCodeValues.isNotEmpty)
                      ? weatherCodeValues[1]
                      : '0';

              forecastList.add({
                'day': DateFormat('EEEE').format(forecastDate),
                'date': DateFormat('dd MMM yyyy').format(forecastDate),
                'temperature': temperature.toString(),
                'weatherCode': weatherCode.toString(),
              });
            }
          }
        }
        return forecastList;
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Map<String, dynamic> _parseXmlToJson(String xmlData) {
    xml2json.parse(xmlData);
    var jsonString = xml2json.toParker();
    print(jsonString);
    // Check if jsonString is not null before decoding
    // ignore: unnecessary_null_comparison
    return jsonString != null ? json.decode(jsonString) : null;
  }
}



    // Implement XML to JSON parsing logic here
    // For simplicity, I'm skipping the actual parsing logic in this example
// Placeholder for parsed JSON data

  // Future<List<Map<String, dynamic>>> fetchWeatherForecast() async {
  //   final response = await http.get(Uri.parse(apiUrl));
  //   final DateTime now = DateTime.now();
  //   final DateFormat dateFormat = DateFormat('yyyyMMddTHHmm');

  //   final List<Map<String, dynamic>> forecastList = [];

  //   if (jsonData['data']['forecast']['area'] is List) {
  //     var areaList = jsonData['data']['forecast']['area'];

  //     for (var area in areaList) {
  //       var forecastDates = area['parameter'][1]['timerange'];
  //       for (var date in forecastDates) {
  //         DateTime forecastDate = dateFormat.parse(date['@datetime']);
  //         print('Processing date: $forecastDate'); // Logging forecast date
  //         if (forecastDate.isAfter(now) &&
  //             forecastDate.isBefore(now.add(Duration(days: 5)))) {
  //           var temperatureValues =
  //               area['parameter'][5]['timerange'][0]['value'];
  //           var weatherCodeValues =
  //               area['parameter'][6]['timerange'][0]['value'];

  //           print(
  //               'Temperature values: $temperatureValues'); // Logging temperature values
  //           print(
  //               'Weather code values: $weatherCodeValues'); // Logging weather code values

  //           var temperature =
  //               (temperatureValues is List && temperatureValues.isNotEmpty)
  //                   ? temperatureValues[0]
  //                   : 'N/A';
  //           var weatherCode =
  //               (weatherCodeValues is List && weatherCodeValues.isNotEmpty)
  //                   ? weatherCodeValues[1]
  //                   : '0';

  //           print('Temperature: $temperature'); // Logging temperature
  //           print('Weather code: $weatherCode'); // Logging weather code
  //           print(
  //               'Adding forecast for date: $forecastDate with temp $temperature and code $weatherCode'); // Logging added date
  //           forecastList.add({
  //             'day': DateFormat('EEEE').format(forecastDate),
  //             'date': DateFormat('dd MMM yyyy').format(forecastDate),
  //             'temperature': temperature?.toString(),
  //             'weatherCode': weatherCode?.toString(),
  //           });
  //         }
  //       }
  //     }
  //   } else {
  //     throw Exception('Unexpected JSON structure');
  //   }
  //   print('Final forecast list: $forecastList'); // Logging final list
  //   return forecastList;
  // }
