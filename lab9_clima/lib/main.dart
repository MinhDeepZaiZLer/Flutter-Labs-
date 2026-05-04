import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const ClimaApp());

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String temperature = '...';
  String cityName = 'Đang tải...';
  String weatherIcon = '☁️';
  
  final String apiKey = '1f461c5f5e705e07aa7e1af432aa146e'; 

  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  Future<void> getLocationAndWeather() async {
    double lat = 16.0544; // Mặc định: Đà Nẵng
    double lon = 108.2022;

    try {
      // 1. Xin quyền và lấy Location
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
        lat = position.latitude;
        lon = position.longitude;
      }
    } catch (e) {
      print('Không lấy được GPS, sử dụng tọa độ mặc định.');
    }

    // 2. Gọi API thời tiết
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
    
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);

        setState(() {
          double temp = decodedData['main']['temp'];
          temperature = temp.toStringAsFixed(1); // Lấy 1 chữ số thập phân
          cityName = decodedData['name'];
          
          int condition = decodedData['weather'][0]['id'];
          weatherIcon = getWeatherIcon(condition);
        });
      } else {
        setState(() {
          cityName = 'Lỗi gọi API';
        });
      }
    } catch (e) {
      setState(() {
        cityName = 'Mất mạng';
      });
    }
  }

  // Hàm phụ: Đổi mã ID thời tiết thành Icon emoji
  String getWeatherIcon(int condition) {
    if (condition < 300) { return '🌩'; }
    else if (condition < 400) { return '🌧'; }
    else if (condition < 600) { return '☔️'; }
    else if (condition < 700) { return '☃️'; }
    else if (condition < 800) { return '🌫'; }
    else if (condition == 800) { return '☀️'; }
    else if (condition <= 804) { return '☁️'; }
    else { return '🤷‍'; }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                weatherIcon,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 100.0),
              ),
              const SizedBox(height: 20.0),
              Text(
                '$temperature°C',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
              ),
              Text(
                cityName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 40.0, letterSpacing: 2.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}