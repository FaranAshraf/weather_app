import 'package:flutter/material.dart';

import 'package:weather_app/functions/getAPIresponse.dart';
import 'package:weather_app/utils/appcolors.dart';

class FutureWeatherBoxes extends StatefulWidget {
  final String cityname;
  final String date;

  const FutureWeatherBoxes(
      {super.key, required this.cityname, required this.date});

  @override
  State<FutureWeatherBoxes> createState() => _FutureWeatherBoxesState();
}

class _FutureWeatherBoxesState extends State<FutureWeatherBoxes> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            getfutureAPIresponse(cityname: widget.cityname, date: widget.date),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Display loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Display error if any
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 40),
              child: Card(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Text(
                      "Today's Hourly Update of ${widget.cityname.toUpperCase()}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Jaro'),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < snapshot.data!.hour!.length; i++)
                            Container(
                              decoration: BoxDecoration(
                                  gradient: MyAppColors.cardTileColor,
                                  borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.only(
                                top: 40,
                                left: 10,
                                bottom: 20,
                              ),
                              width: 50,
                              child: Column(
                                children: [
                                  Text(
                                    i < 10 ? '0$i:00' : '$i:00',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Jaro'),
                                  ),
                                  Text(
                                    '${snapshot.data!.hour![i]['temp_c']}⁰C',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.network(
                                        'https:${snapshot.data!.hour![i]['condition']['icon']}'),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
