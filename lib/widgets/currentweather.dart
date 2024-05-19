import 'package:flutter/material.dart';
import 'package:weather_app/functions/getAPIresponse.dart';
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
    return FutureBuilder(
        future: getAPIresponse(cityname: widget.cityname),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Display loading indicator
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Invalid Entry!',
                style: TextStyle(
                    fontSize: 41, color: Colors.white, fontFamily: 'Jaro'),
              ),
            );
          } else {
            return Container(
              height: 250,
              decoration: BoxDecoration(
                  gradient: MyAppColors.cardTileColor,
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(top: 70, right: 8, left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                            style: TextStyle(
                                fontSize: 41,
                                color: Colors.white,
                                fontFamily: 'Jaro'),
                            'NOW'),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: StreamBuilder(
                          stream:
                              getTimeZones(timeZone: snapshot.data!.timeZone!),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            return Text(
                              snapshot2.data!.time!,
                              style: const TextStyle(
                                  fontSize: 41,
                                  color: Colors.white,
                                  fontFamily: 'Jaro'),
                            );
                          },
                        ),
                      )
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
                                style: const TextStyle(
                                    fontSize: 41,
                                    color: Colors.white,
                                    fontFamily: 'Jaro'),
                                '${snapshot.data!.temp}⁰C'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                                style: const TextStyle(color: Colors.white),
                                '${snapshot.data!.city}, ${snapshot.data!.country}'),
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
                              image:
                                  NetworkImage('https:${snapshot.data!.icon}')),
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
                            'Wind Speed ${snapshot.data!.speed}mph',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          width: 130,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 10),
                          child: Text(
                            snapshot.data!.condition!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
