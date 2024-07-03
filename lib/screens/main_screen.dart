import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../7daysweather/weatherdetail.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeather("Jakarta");
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff5842A9),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff331C71),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image(
                            color: Colors.white,
                            image: AssetImage('assets/icons/menu1.png'),
                          ),
                        ),
                      ),
                      Text(
                        weatherData.cityName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff331C71),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              weatherData.fetchWeather(weatherData.cityName);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Enter City',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        weatherData.fetchWeather(_cityController.text);
                      },
                    ),
                  ),
                  onSubmitted: (_) {
                    weatherData.fetchWeather(_cityController.text);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  weatherData.description,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Stack(
                  children: [
                    Text(
                      '${weatherData.temperature}°',
                      style: TextStyle(
                          fontSize: 150,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Opacity(
                      opacity: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 320.0, top: 80),
                        child: Image(
                          height: 150,
                          image: AssetImage('assets/icons/mainimg.png'),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  '${weatherData.currentDateTime}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 120,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xff331C71),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 9),
                        child: Column(
                          children: [
                            Image(
                              height: 40,
                              image: AssetImage('assets/icons/visibility.png'),
                            ),
                            Text(
                              '${weatherData.visibility} Km',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Visibility',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Column(
                          children: [
                            Image(
                              height: 40,
                              image: AssetImage('assets/icons/drop.png'),
                            ),
                            Text(
                              '${weatherData.humidity}%',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Humidity',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, right: 8),
                        child: Column(
                          children: [
                            Image(
                              height: 40,
                              image: AssetImage('assets/icons/wind.png'),
                            ),
                            Text(
                              '${weatherData.windSpeed} km/h',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Wind Speed',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeatherDetail()),
                        );
                      },
                      child: Text(
                        '7-Day Forecasts',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weatherData.forecast.length,
                    itemBuilder: (ctx, i) {
                      final forecastItem = weatherData.forecast[i];
                      final dateTime = DateTime.fromMillisecondsSinceEpoch(
                          forecastItem['dt'] * 1000);

                      // Pemetaan deskripsi cuaca ke gambar
                      String description =
                          forecastItem['weather'][0]['description'];
                      String weatherImage;
                      switch (description) {
                        case 'overcast clouds':
                          weatherImage = 'assets/icons/overcast.png';
                          break;
                        case 'broken clouds':
                          weatherImage = 'assets/icons/broken-cloud.png';
                          break;
                        case 'light rain':
                          weatherImage = 'assets/icons/raining.png';
                          break;
                        case 'scattered clouds':
                          weatherImage = 'assets/icons/scattered-cloud.png';
                          break;
                        default:
                          weatherImage = 'assets/icons/mainimg.png';
                      }

                      return Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 140, // Menetapkan tinggi agar tidak terlalu memanjang ke bawah
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // Mengubah background menjadi putih
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${forecastItem['main']['temp']}°',
                                style: TextStyle(color: Colors.black), // Mengubah warna teks menjadi hitam
                              ),
                              Image(
                                height: 40,
                                image: AssetImage(weatherImage),
                              ),
                              Text(
                                '${dateTime.hour}:00',
                                style: TextStyle(color: Colors.black), // Mengubah warna teks menjadi hitam
                              ),
                              Visibility(
                                visible: false,
                                child: Text(
                                  description,
                                  style: TextStyle(color: Colors.black), // Mengubah warna teks menjadi hitam
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
