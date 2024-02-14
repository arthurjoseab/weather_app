import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/addition_item.dart';
import 'package:weather_app/hourly_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  //double temp = 0;
  // bool isloding = false;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getCurrentWeather();
  // }
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      // setState(() {
      //   isloding = true;
      // });
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=f9c714c14afdb772bcd29b60e719da97'),
      );
      final data = jsonDecode(res.body);
      //or  if(int.parse(data['cod'])!=200){}
      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
        // throw data['message'].toString();
      }
      return data;

      // setState(() {
      //   temp = data['list'][0]['main']['temp'];
      //  // isloding = false;
      // });
    } catch (e) {
      throw e.toString();
    }

    // print(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Weather App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
              // print('refresh');
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: //isloding
          //temp == 0
          //? const Center(child: CircularProgressIndicator())
          // :
          FutureBuilder(
        future: weather,
        // future: getCurrentWeather(),
        builder: (context, snapshort) {
          // print(snapshort);
          if (snapshort.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshort.hasError) {
            return Text(snapshort.error.toString());
          }

          final data = snapshort.data!;
          final currentweather = data['list'][0];
          final currentTemp = currentweather['main']['temp'];
          final currentSky = currentweather['weather'][0]['main'];
          final currentpressure = currentweather['main']['pressure'];
          final currentWindSpeed = currentweather['wind']['speed'];
          final currentHumidity = currentweather['main']['humidity'];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp k',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                ),
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 30,
                              ),
                              const Text(
                                'Rain',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 5; i++)
                //         HurlyFocusCard(
                //           time: data['list'][i + 1]['dt'].toString(),
                //           temprature:
                //               data['list'][i + 1]['main']['temp'].toString(),
                //           icon: data['list'][i + 1]['weather'][0]['main'] ==
                //                       'Cloud' ||
                //                   data['list'][i + 1]['weather'][0]['main'] ==
                //                       'Rain'
                //               ? Icons.cloud
                //               : Icons.sunny,
                //         ),

                //       // HurlyFocusCard(
                //       //   time: '9:01',
                //       //   temprature: '300.52',
                //       //   icon: Icons.sunny,
                //       // ),
                //       // HurlyFocusCard(
                //       //   time: '9:01',
                //       //   temprature: '300.12',
                //       //   icon: Icons.cloud,
                //       // ),
                //       // HurlyFocusCard(
                //       //   time: '9:01',
                //       //   temprature: '301.09',
                //       //   icon: Icons.sunny,
                //       // ),
                //       // HurlyFocusCard(
                //       //   time: '9:01',
                //       //   temprature: '301.09',
                //       //   icon: Icons.cloud,
                //       // ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (contuxt, index) {
                        final hourlyForcast = data['list'][index + 1];
                        final hourlysky = hourlyForcast['weather'][0]['main'];
                        final time = DateTime.parse(hourlyForcast['dt_txt']);

                        return HurlyFocusCard(
                          time: DateFormat.j().format(time),
                          temprature: hourlyForcast['main']['temp'].toString(),
                          icon: hourlysky == 'Cloud' || hourlysky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      }),
                ),
                const Text(
                  'Addition Information',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Additional_item(
                        icon_name: Icons.water_drop,
                        text: 'Humidity',
                        value: currentHumidity.toString()),
                    Additional_item(
                        icon_name: Icons.air,
                        text: 'Wind speed',
                        value: currentWindSpeed.toString()),
                    Additional_item(
                        icon_name: Icons.beach_access,
                        text: 'Pressure',
                        value: currentpressure.toString()),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
