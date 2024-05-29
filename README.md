# SailWatch Mobile App

SailWatch Mobile App is a Flutter application that provides weather information for sailors. It fetches weather data from an API provided by the Indonesian Agency for Meteorology, Climatology, and Geophysics (BMKG).

## Getting Started

To get started with the SailWatch Mobile App, follow these steps:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/sailwatch-mobile.git
   ```

2. Navigate into the project directory sailwatch_mobile2:

    ```bash
    cd sailwatch_mobile2
    ```

3. Install dependencies using Flutter:

    ```bash
    flutter pub get
    ```

4. Run the app on your preferred device:

    ```bash
    flutter run
    ```


## Fetching Weather Data

The app fetches weather data from the BMKG API using the 'XmlToJsonService' class provided in the 'services' directory. This service fetches XML data from the BMKG API and converts it to JSON format for easier processing

Weather services code ( xml to json ):

    ```dart
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
    ```


To fetch weather data:

    ```dart
    import 'package:sailwatch_mobile/services/weatherServices.dart';

    // Inside your StatefulWidget or StatelessWidget
    XmlToJsonService xmlToJsonService = XmlToJsonService();
    Map<String, dynamic> data = await xmlToJsonService.fetchAndConvertXmlToJson();
    ```


or 

You can look and check this link to get another data

Weather api from ibnux github [wilayah](https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json) and [cuaca](https://ibnux.github.io/BMKG-importer/cuaca/501601.json)



# Contributing

1. Clone repository

2. Make a new branch before start to code

    ```bash
    git checkout -b new-branch // nama branch baru
    ```
3. Make changes with the code

4. Push
    push ke branch yang baru dibuat

    ```bash
    git push -u origin new-branch
    ```