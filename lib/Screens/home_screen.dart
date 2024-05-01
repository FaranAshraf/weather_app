import 'package:flutter/material.dart';
import 'package:weather_app/Screens/backgroundimae.dart';

import 'package:weather_app/widgets/currentweather.dart';
import 'package:weather_app/widgets/futureweatherboxes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController citynamecontroller = TextEditingController();
  String cityname = '';
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackgroundImage(),
        SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
                child: TextField(
                  maxLength: 30,
                  spellCheckConfiguration: const SpellCheckConfiguration(),
                  controller: citynamecontroller,
                  decoration: const InputDecoration(
                      labelText: 'Enter city name', icon: Icon(Icons.search)),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    setState(() {
                      cityname = value;
                      isPressed = true;
                      citynamecontroller.clear();
                    });
                  },
                ),
              ),
              CurrentWeatherWidget(
                cityname: isPressed ? cityname : 'karachi',
              ),
              FutureWeatherBoxes(cityname: isPressed ? cityname : 'karachi'),
            ],
          ),
        ),
      ]),
    );
  }
}
