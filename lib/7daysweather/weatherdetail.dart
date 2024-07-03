import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherDetail extends StatefulWidget {
  const WeatherDetail({Key? key}) : super(key: key);

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xff331C71),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff5842A9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '7 days',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 17),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff5842A9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        color: Colors.white,
                        image: AssetImage('assets/icons/dots (1).png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              
                Expanded(
                  child: ListView.builder(
                    itemCount: weatherData.forecast.length,
                    itemBuilder: (ctx, i) {
                      final forecastItem = weatherData.forecast[i];
                      final dateTime = DateTime.fromMillisecondsSinceEpoch(
                          forecastItem['dt'] * 1000);
                      final formattedDate = 
                          "${dateTime.weekday == DateTime.monday ? 'Monday' : dateTime.weekday == DateTime.tuesday ? 'Tuesday' : dateTime.weekday == DateTime.wednesday ? 'Wednesday' : dateTime.weekday == DateTime.thursday ? 'Thursday' : dateTime.weekday == DateTime.friday ? 'Friday' : dateTime.weekday == DateTime.saturday ? 'Saturday' : 'Sunday'}";

                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Color(0xff5842A9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image(
                                      height: 40,
                                      image: AssetImage(
                                          'assets/icons/${forecastItem['weather'][0]['main'].toLowerCase()}.png'),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      forecastItem['weather'][0]['main'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '${forecastItem['main']['temp_max']}°',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${forecastItem['main']['temp_min']}°',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
