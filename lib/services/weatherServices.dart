import 'dart:convert';
import 'package:http/http.dart' as http;
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
      return json.decode(jsonString);
    } else {
      throw Exception('Failed to load XML data');
    }
  }
}