import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sailwatch_mobile/Pages/ForecastPage/forecastPage.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/HourlyWeatherCard.dart';
import 'package:sailwatch_mobile/Pages/Homepage/widget/weatherDetail.dart';
import 'package:sailwatch_mobile/services/weatherServices.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final XmlToJsonService xmlToJsonService = XmlToJsonService();
  late Future<Map<String, dynamic>> jsonData;
  DateTime now = DateTime.now();

  late String currentDateFormatted;

  @override
  void initState() {
    super.initState();
    jsonData = xmlToJsonService.fetchAndConvertXmlToJson();
    jsonData.then((data) {
      print(
          'Fetched and converted JSON data: $data'); // Tambahkan log ini untuk melihat data asli
      setState(() {});
    });
    currentDateFormatted = DateFormat('EEEE, d MMM yyyy').format(now);
  }

  num parseNumber(dynamic value) {
    if (value is num) {
      return value;
    } else if (value is String) {
      return num.parse(value.replaceAll(',', '.'));
    } else {
      throw FormatException('Invalid number format: $value');
    }
  }

  String getWeatherIconPath(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'assets/images/sunny.png';
      case 1:
        return 'assets/images/clear.png';
      case 2:
        return 'assets/images/moderateorheavyrainshower.png';
      case 3:
        return 'assets/images/cloud.png';
      case 4:
        return 'assets/images/cloudy.png';
      case 5:
        return 'assets/images/heavycloud.png';
      case 10:
        return 'assets/images/overcast.png';
      case 45:
        return 'assets/images/overcast.png';
      case 60:
        return 'assets/images/lightdrizzle.png';
      case 61:
        return 'assets/images/lightrainshower.png';
      case 63:
        return 'assets/images/lightrain.png';
      case 80:
        return 'assets/images/lightdrizzle.png';
      case 95:
        return 'assets/images/moderaterain.png';
      case 97:
        return 'assets/images/moderateorheavyrainwithunder.png';
      default:
        return 'assets/images/sunny.png';
    }
  }

  String getWeatherDescription(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'Cerah';
      case 1:
      case 2:
        return 'Cerah Berawan';
      case 3:
        return 'Berawan';
      case 4:
        return 'Berawan Tebal';
      case 5:
        return 'Udara Kabur';
      case 10:
        return 'Asap';
      case 45:
        return 'Kabut';
      case 60:
        return 'Hujan Ringan';
      case 61:
        return 'Hujan Sedang';
      case 63:
        return 'Hujan Lebat';
      case 80:
        return 'Gerimis Ringan';
      case 95:
        return 'Hujan Sedang Disertai Petir';
      case 97:
        return 'Hujan Lebat Disertai Petir';
      default:
        return 'Cerah';
    }
  }

  int parseWeatherCode(dynamic weatherCodeValue) {
    if (weatherCodeValue is int) {
      return weatherCodeValue;
    } else if (weatherCodeValue is double) {
      return weatherCodeValue.toInt();
    } else {
      print('Invalid weather code format: $weatherCodeValue');
      return 0;
    }
  }

  String formatDateTime(String datetime) {
    try {
      // Parsing format datetime dari XML
      DateTime dt = DateFormat("yyyyMMddHHmm").parse(datetime);
      // Format waktu menjadi format yang diinginkan
      String formattedTime = DateFormat('HH:mm').format(dt);
      return formattedTime;
    } catch (e) {
      print('Error parsing datetime: $datetime, error: $e');
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          child: FutureBuilder<Map<String, dynamic>>(
            future: jsonData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Tidak ada data tersedia'));
              } else {
                try {
                  var area = snapshot.data!['data']['forecast']['area'];

                  if (area is List && area.isNotEmpty) {
                    var weatherData = area[0]['parameter'];
                    var cityName = area[0]['name'][0];
                    var hourlyWeather = weatherData[5]['timerange'];

                    // Log seluruh data hourlyWeather
                    print('Hourly weather data: $hourlyWeather');

                    var weatherCodeValue = weatherData.length > 6 &&
                            weatherData[6]['timerange'].length > 0 &&
                            weatherData[6]['timerange'][0]['value'].length > 1
                        ? parseNumber(
                            weatherData[6]['timerange'][0]['value'][1])
                        : 0;

                    var temperature = '';
                    var windSpeed = '';
                    var humidity = '';

                    int weatherCode = parseWeatherCode(weatherCodeValue);

                    try {
                      temperature = weatherData.length > 5 &&
                              weatherData[5]['timerange'].length > 0 &&
                              weatherData[5]['timerange'][0]['value'].length > 0
                          ? parseNumber(
                                  weatherData[5]['timerange'][0]['value'][0])
                              .toString()
                          : 'N/A';

                      windSpeed = weatherData.length > 8 &&
                              weatherData[8]['timerange'].length > 0 &&
                              weatherData[8]['timerange'][0]['value'].length > 0
                          ? parseNumber(
                                  weatherData[8]['timerange'][0]['value'][0])
                              .toString()
                          : 'N/A';

                      humidity = weatherData.length > 6 &&
                              weatherData[6]['timerange'].length > 0 &&
                              weatherData[6]['timerange'][0]['value'].length > 0
                          ? parseNumber(
                                  weatherData[6]['timerange'][0]['value'][0])
                              .toString()
                          : 'N/A';
                    } catch (e) {
                      print('Error converting data to string: $e');
                    }

                    return Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                cityName,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                currentDateFormatted,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Image.asset(
                              getWeatherIconPath(weatherCode),
                              width: 250,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              getWeatherDescription(weatherCode),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        WeatherDetails(
                          temperature: temperature,
                          windSpeed: windSpeed,
                          humidity: humidity,
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today",
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const forecastPage(),
                                ));
                              },
                              child: Text(
                                "View Full Forecast",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xFF1d86de),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: hourlyWeather.map<Widget>((hourData) {
                              // Log untuk memeriksa struktur data
                              print('hourData: ${hourData}');

                              var time = (hourData != null &&
                                      hourData.containsKey('@datetime') &&
                                      hourData['@datetime'] != null)
                                  ? formatDateTime(hourData['@datetime'])
                                  : 'N/A';

                              print(
                                  'Formatted time: $time'); // Log tambahan untuk melihat waktu terformat

                              var temp = hourData['value'] != null &&
                                      hourData['value'].length > 0
                                  ? parseNumber(hourData['value'][0]).toString()
                                  : 'N/A';

                              var iconPath = hourData['value'] != null &&
                                      hourData['value'].length > 1
                                  ? getWeatherIconPath(
                                      parseNumber(hourData['value'][1]).toInt())
                                  : getWeatherIconPath(0);

                              return HourlyWeatherItem(
                                time: time,
                                temperature: "$temp°C",
                                iconPath: iconPath,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                        child: Text('Data cuaca tidak tersedia'));
                  }
                } catch (e) {
                  print('Error extracting data: $e');
                  return Center(child: Text('Error extracting data: $e'));
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
