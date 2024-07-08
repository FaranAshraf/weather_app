import 'package:flutter/material.dart';
import 'package:weather_app/Models/get_weather_model.dart';

import 'package:weather_app/Models/post_time_model.dart';
import 'package:weather_app/functions/api_references.dart';
import 'package:weather_app/utils/appcolors.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final String cityname;

  const CurrentWeatherWidget({
    Key? key,
    required this.cityname,
  }) : super(key: key);

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetWeatherModel>(
      future: getAPIresponse(cityname: widget.cityname),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'No Data Available',
              style: TextStyle(
                fontSize: 41,
                color: Colors.white,
                fontFamily: 'Jaro',
              ),
            ),
          );
        } else {
          final weatherData = snapshot.data!;
          return Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: MyAppColors.cardTileColor,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(top: 70, right: 8, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 41,
                          color: Colors.white,
                          fontFamily: 'Dancing Script',
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: StreamBuilder<PostTimeModel>(
                        stream: getTimeZones(
                          timeZone: weatherData.timeZone ?? 'Asia/Karachi',
                        ),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot2.hasError || !snapshot2.hasData) {
                            return const Text(
                              'Time Unavailable',
                              style: TextStyle(
                                fontSize: 41,
                                color: Colors.white,
                                fontFamily: 'Jaro',
                              ),
                            );
                          } else {
                            return Text(
                              snapshot2.data!.time!,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontFamily: 'Dancing Script',
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '${weatherData.temp}⁰C',
                            style: const TextStyle(
                              fontSize: 41,
                              color: Colors.white,
                              fontFamily: 'Jaro',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '${weatherData.city}, ${weatherData.country}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Dancing Script'),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('https:${weatherData.icon}'),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 10),
                        child: Text(
                          'Wind Speed ${weatherData.speed} mph',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 130),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 10),
                        child: Text(
                          weatherData.condition ?? '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
