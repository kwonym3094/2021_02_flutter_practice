import 'package:flutter/material.dart';
import 'package:flutter_example/riverpod_state/infrastructure/model/weather.dart';

class WeatherSearchPage extends StatefulWidget {
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Search'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: buildInitInput(),
      ),
    );
  }

  Widget buildInitInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          // Display the temperature with 1 decimal place
          '${weather.temperatureCelsius.toStringAsFixed(1)} °C',
          style: const TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextField(
          onSubmitted: (value) => submitCitiyName(context, value),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Enter a city',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: const Icon(Icons.search),
          ),
        ));
  }

  void submitCitiyName(BuildContext context, String cityName) {}
}
