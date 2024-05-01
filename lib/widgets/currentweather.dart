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
        builder: (context, AsyncSnapshot snapshot) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: MyAppColors.cardTileColor,
                borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.only(top: 50, right: 8, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                      style: const TextStyle(fontSize: 41, color: Colors.white),
                      '${snapshot.data['current']['temp_c']}⁰C'),
                  subtitle: Text(
                      style: const TextStyle(color: Colors.white),
                      '${snapshot.data['location']['name']}, ${snapshot.data['location']['country']}'),
                  trailing: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https:${snapshot.data['current']['condition']['icon']}')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 40, right: 15),
                  child: Row(
                    children: [
                      Text(
                        'Wind Speed ${snapshot.data['current']['wind_mph']}mph',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        snapshot.data['current']['condition']['text'],
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
