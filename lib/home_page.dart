import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/constant/const.dart';

class MyHomePage extends StatefulWidget {
  final cityName;
  const MyHomePage({super.key, this.cityName});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final WeatherFactory _weatherFactory = WeatherFactory(OPEN_WEATHER_API_KEY);
  Weather? _weather;

  @override
  void initState(){
    super.initState();
    _weatherFactory.currentWeatherByCityName(widget.cityName).then((city) {
      setState(() {
        _weather = city;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:_bodyUI(),
    );
  }

  Widget _bodyUI() {
      if (_weather == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _locationHeader(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.08,
              ),
              _dateTimeInfo(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              _weatherIcon(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              _currentTamp(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              _extraInfo(),
            ],
          ),
        );
      }
  }

  Widget _locationHeader(){
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo(){
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(DateFormat("hh:mm a").format(now),
          style: const TextStyle(fontSize: 35),),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 10,),
            Text(DateFormat("d.m.y").format(now),
              style: const TextStyle(fontWeight: FontWeight.w400),)
          ],
        ),
      ],
    );
  }

 Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png")),
          ),
        ),
        Text(_weather?.weatherDescription ?? "", style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),),
      ],
    );
 }

  Widget _currentTamp() {
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
      style: const TextStyle(
          color: Colors.black,
          fontSize: 90,
          fontWeight: FontWeight.bold),);
  }

  Widget _extraInfo(){
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.shade400,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Max : ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C" ?? "",
                    style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),),
                Text("Min : ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C" ?? "",
                  style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Wind : ${_weather?.windSpeed?.toStringAsFixed(0)}m/s" ?? "",
                  style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),),
                Text("Humidity : ${_weather?.humidity?.toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
