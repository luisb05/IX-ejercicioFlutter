class Clima {
  final String mainWeather;
  final String description;
  final double temp;
  final int pressure;
  final int humidity;

  Clima({
    required this.mainWeather,
    required this.description,
    required this.temp,
    required this.pressure,
    required this.humidity,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      mainWeather: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'].toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
    );
  }
}
