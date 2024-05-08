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
            return const CircularProgressIndicator(); // Display loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Display error if any
          } else {
            // String? date = snapshot.data!.date;
            return Container(
              height: 200,
              decoration: BoxDecoration(
                  gradient: MyAppColors.cardTileColor,
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(top: 100, right: 8, left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                        style:
                            const TextStyle(fontSize: 41, color: Colors.white),
                        '${snapshot.data!.temp}⁰C'),
                    subtitle: Text(
                        style: const TextStyle(color: Colors.white),
                        '${snapshot.data!.city}, ${snapshot.data!.country}'),
                    trailing: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                NetworkImage('https:${snapshot.data!.icon}')),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 15, top: 42,
                            //right: 15
                          ),
                          child: Text(
                            'Wind Speed ${snapshot.data!.speed}mph',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        //const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 30),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 50, top: 44, right: 20),
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
