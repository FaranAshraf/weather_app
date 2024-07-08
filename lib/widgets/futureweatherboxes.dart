import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/functions/api_references.dart';
import 'package:weather_app/utils/appcolors.dart';

class FutureWeatherBoxes extends StatefulWidget {
  final String cityname;
  final String date;

  const FutureWeatherBoxes({
    Key? key,
    required this.cityname,
    required this.date,
  }) : super(key: key);

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
          return const Center(child: CircularProgressIndicator());
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
          return Container(
            height: 200,
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(right: 8, left: 8, top: 70),
            decoration: BoxDecoration(
              gradient: MyAppColors.cardTileColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Today's Hourly Update of ${widget.cityname.toUpperCase()}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Jaro',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < snapshot.data!.hour!.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat.jm().format(DateTime.parse(
                                      snapshot.data!.hour![i]["time"])),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Jaro',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${snapshot.data!.hour![i]["temp_c"] ?? 'temp error'}⁰C',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Image.network(
                                    'https:${snapshot.data!.hour![i]["condition"]["icon"]}',
                                  ),
                                ),
                              ],
                            ),
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
