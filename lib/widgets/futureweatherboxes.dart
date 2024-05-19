import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  List<String> formattedTimes = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            getfutureAPIresponse(cityname: widget.cityname, date: widget.date),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            formattedTimes.clear();

            for (var hourData in snapshot.data!.hour!) {
              DateTime time = DateTime.parse(hourData['time']);
              String formattedTime = DateFormat.jm().format(time);
              formattedTimes.add(formattedTime);
            }

            return Container(
              margin: const EdgeInsets.only(right: 8, left: 8, top: 70),
              child: Container(
                decoration: BoxDecoration(
                    gradient: MyAppColors.cardTileColor,
                    borderRadius: BorderRadius.circular(15)),
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
                        children:
                            List.generate(snapshot.data!.hour!.length, (i) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                              left: 10,
                              bottom: 20,
                            ),
                            child: Material(
                              elevation: 5,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        formattedTimes[i],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Jaro'),
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data!.hour![i]['temp_c']}⁰C',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.network(
                                          'https:${snapshot.data!.hour![i]['condition']['icon']}'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
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
