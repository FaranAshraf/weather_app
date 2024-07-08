import 'package:flutter/material.dart';
import 'package:weather_app/functions/api_references.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: FutureBuilder(
                future: getfutureAPIresponse(
                    cityname: 'karachi', date: '2024-05-20'),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      for (var i = 0; i < snapshot.data!.hour!.length; i++)
                        Text(snapshot.data!.hour![i]["temp_c"].toString())
                    ],
                  );
                })),
      ),
    );
  }
}
