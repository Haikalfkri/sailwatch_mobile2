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
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Xml2Json xml2json = Xml2Json(); // Initialize xml2json
        xml2json.parse(response.body); // Parse XML to json-like
        var jsonData = xml2json.toParker(); // Convert xml to json

        var decodedData = jsonDecode(jsonData); // Decode JSON

        List<Map<String, dynamic>> forecasts = [];

        // Iterate over each area
        var areas = decodedData['data']['forecast']['area'];
        if (areas is List) {
          for (var area in areas) {
            var areaId = area['@id'];
            var areaName = area['name'][0]['\$t']; // English name

            // Initialize variables to store parameter data
            List<Map<String, dynamic>> temperatureData = [];
            List<Map<String, dynamic>> humidityData = [];
            List<Map<String, dynamic>> windSpeedData = [];

            // Extract temperature data
            var tempParameter = area['parameter'].firstWhere(
                (param) => param['@id'] == 't' && param['timerange'] is List,
                orElse: () => null);
            if (tempParameter != null) {
              var tempRanges = tempParameter['timerange'];
              for (var entry in tempRanges) {
                var dateTime = DateTime.parse(entry['@datetime']);
                var tempValues = entry['value'];
                var temperatureC = tempValues.firstWhere(
                    (value) => value['unit'] == 'C',
                    orElse: () => null)['\$t'];
                if (temperatureC != null) {
                  temperatureData.add({
                    'dateTime': dateTime,
                    'temperatureC': double.parse(temperatureC),
                  });
                }
              }
            }

            // Extract humidity data
            var humidityParameter = area['parameter'].firstWhere(
                (param) => param['@id'] == 'hu' && param['timerange'] is List,
                orElse: () => null);
            if (humidityParameter != null) {
              var humRanges = humidityParameter['timerange'];
              for (var entry in humRanges) {
                var dateTime = DateTime.parse(entry['@datetime']);
                var humidityValue = entry['value'].firstWhere(
                    (value) => value['unit'] == '%',
                    orElse: () => null)['\$t'];
                if (humidityValue != null) {
                  humidityData.add({
                    'dateTime': dateTime,
                    'humidity': int.parse(humidityValue),
                  });
                }
              }
            }

            // Extract wind speed data
            var windParameter = area['parameter'].firstWhere(
                (param) => param['@id'] == 'ws' && param['timerange'] is List,
                orElse: () => null);
            if (windParameter != null) {
              var windRanges = windParameter['timerange'];
              for (var entry in windRanges) {
                var dateTime = DateTime.parse(entry['@datetime']);
                var windSpeedValue = entry['value'].firstWhere(
                    (value) => value['unit'] == 'Kt',
                    orElse: () => null)['\$t'];
                if (windSpeedValue != null) {
                  windSpeedData.add({
                    'dateTime': dateTime,
                    'windSpeedKt': double.parse(windSpeedValue),
                  });
                }
              }
            }

            // Add forecast data for this area
            forecasts.add({
              'areaId': areaId,
              'areaName': areaName,
              'temperatureData': temperatureData,
              'humidityData': humidityData,
              'windSpeedData': windSpeedData,
            });
          }
        } else {
          print('Error: No areas found');
        }

        return forecasts;
      } else {
        print(
            'Error: Failed to load weather data, status code: ${response.statusCode}');
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      throw Exception('Error fetching weather data');
    }
  }
}

//   Future<List<Map<String, dynamic>>> fetchWeatherForecast() async {
//     try {
//       // Fetch the XML data from the API
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         // Convert XML to JSON-like format
//         xml2json.parse(response.body);
//         var jsonData = xml2json.toParker();

//         // Decode the JSON data
//         var decodedData = jsonDecode(jsonData);

//         // Extract relevant forecast data
//         List<Map<String, dynamic>> forecasts = [];
//         var forecastList = decodedData['data']['forecast']['area']['parameter'];

//         // Ensure we have the correct data structure
//         if (forecastList is List) {
//           for (var parameter in forecastList) {
//             // Check if the parameter contains temperature data
//             if (parameter['@id'] == 't') {
//               var tempData = parameter['timerange'];

//               if (tempData is List) {
//                 for (var entry in tempData) {
//                   // Extract date and temperature
//                   var dateTime = DateTime.parse(entry['@datetime']);
//                   if (dateTime.isAfter(DateTime.now())) {
//                     var temperature =
//                         entry['value']['\$t']; // Extract the temperature value
//                     forecasts.add({
//                       'day': DateFormat('EEEE').format(dateTime),
//                       'date': DateFormat('yMd').format(dateTime),
//                       'temperature': temperature,
//                       'weatherCode':
//                           '0', // Placeholder, replace with actual code
//                     });
//                   }
//                 }
//               } else if (tempData is Map) {
//                 // If there's only one entry, handle it as a single map
//                 var dateTime = DateTime.parse(tempData['@datetime']);
//                 var temperature =
//                     tempData['value']['\$t']; // Extract the temperature value
//                 forecasts.add({
//                   'day': DateFormat('EEEE').format(dateTime),
//                   'date': DateFormat('yMd').format(dateTime),
//                   'temperature': temperature,
//                   'weatherCode': '0', // Placeholder, replace with actual code
//                 });
//               }
//             }
//           }
//         } else {
//           print('Error: forecastList is not a List');
//         }

//         // Return the forecast data
//         return forecasts;
//       } else {
//         print(
//             'Error: Failed to load weather data, status code: ${response.statusCode}');
//         throw Exception('Failed to load weather data');
//       }
//     } catch (e) {
//       print('Error fetching weather data: $e');
//       throw Exception('Error fetching weather data');
//     }
//   }
// }

