import 'package:flutter/material.dart';

import 'package:weather_app/Screens/backgroundimae.dart';
import 'package:weather_app/functions/getAPIresponse.dart';

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
          child: SafeArea(
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      maxLength: 30,
                      controller: citynamecontroller,
                      decoration: InputDecoration(
                        labelText: 'Enter city/country',
                        suffixIcon: GestureDetector(
                          child: const Icon(Icons.search),
                          onTap: () {
                            setState(() {
                              cityname = citynamecontroller.text;
                              isPressed = cityname.isEmpty ? false : true;
                              citynamecontroller.clear();
                            });
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        setState(() {
                          cityname = value.isEmpty ? 'karachi' : value;
                          isPressed = cityname.isEmpty ? false : true;
                          citynamecontroller.clear();
                        });
                      },
                    ),
                  ),
                ),
                CurrentWeatherWidget(
                  cityname: isPressed ? cityname : 'karachi',
                ),
                FutureBuilder(
                    future: getAPIresponse(
                        cityname: isPressed ? cityname : "karachi"),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'City/Country Not Found!',
                            style: TextStyle(
                                fontSize: 41,
                                color: Colors.white,
                                fontFamily: 'Jaro'),
                          ),
                        );
                      } else {
                        return FutureWeatherBoxes(
                          date: snapshot.data!.date!,
                          cityname: isPressed ? cityname : 'karachi',
                        );
                      }
                    })),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
