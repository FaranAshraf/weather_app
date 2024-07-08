import 'package:flutter/material.dart';

import 'package:weather_app/Screens/backgroundimae.dart';
import 'package:weather_app/functions/api_references.dart';
import 'package:weather_app/utils/appcolors.dart';
import 'package:weather_app/widgets/currentweather.dart';
import 'package:weather_app/widgets/futureweatherboxes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController citynamecontroller = TextEditingController();
  String cityname = 'karachi';
  bool isPressed = false;

  @override
  void dispose() {
    citynamecontroller.dispose();
    super.dispose();
  }

  void updateCityName() {
    setState(() {
      cityname = citynamecontroller.text.isNotEmpty
          ? citynamecontroller.text
          : 'karachi';
      isPressed = citynamecontroller.text.isNotEmpty;
      citynamecontroller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: MyAppColors.searchbarcolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        style: const TextStyle(color: Color(0xffEBEBF5)),
                        maxLength: 30,
                        controller: citynamecontroller,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Color(0xffEBEBF5)),
                          labelText: 'Enter city/country',
                          suffixIcon: GestureDetector(
                            onTap: updateCityName,
                            child: const Icon(
                                color: Color(0xffEBEBF5), Icons.search),
                          ),
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => updateCityName(),
                      ),
                    ),
                  ),
                  CurrentWeatherWidget(
                    cityname: isPressed ? cityname : 'karachi',
                  ),
                  FutureBuilder(
                    future: getAPIresponse(
                        cityname: isPressed ? cityname : 'karachi'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Invalid Entry! Please enter a valid city or country.',
                            style: TextStyle(
                              fontSize: 41,
                              color: Colors.white,
                              fontFamily: 'Jaro',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(
                          child: Text(
                            'City/Country Not Found!',
                            style: TextStyle(
                              fontSize: 41,
                              color: Colors.white,
                              fontFamily: 'Jaro',
                            ),
                          ),
                        );
                      } else {
                        return FutureWeatherBoxes(
                          date: snapshot.data!.trueDate.toString(),
                          cityname: isPressed ? cityname : 'karachi',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
