import 'package:flutter/material.dart';
import 'package:weather_app/home_page.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0.8, 1),
          colors: <Color>[
            Colors.blue.shade700.withOpacity(1.0),
            Colors.blue.shade100.withOpacity(1.0),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Stack(
                children: [
                  Icon(
                    Icons.cloud,
                    size: 200,
                    color: Colors.white,
                  ),
                  Positioned(
                      bottom: 3,
                      left: 80,
                      child:
                      Icon(Icons.sunny, color: Colors.yellow, size: 100)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search city ",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  String cityName = cityController.text.trim();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            cityName: cityName,
                          ),),);
                  cityController.clear();
                },
                child: const Text("Check Weather"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
