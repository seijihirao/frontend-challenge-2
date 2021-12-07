/// Weather object containing [city] contition
class Weather {
  final int id;
  final String city;
  final String main;
  final WeatherCondition condition;

  Weather(this.id, this.city, this.main, this.condition);

  /// We only need to compare [id] on equals
  @override
  bool operator ==(Object other) {
    return id == (other as Weather).id;
  }

  /// Create a hascode based on [id], [city] and [main] weather aspects
  @override
  int get hashCode => Object.hash(id, city, main);
}

/// Weather condition object, containint [temperature], [pressure] and [humidity]
class WeatherCondition {
  final double temperature;
  final double feelsLike;
  final double temperatureMin;
  final double temperatureMax;
  final int pressure;
  final int humidity;

  WeatherCondition(this.temperature, this.feelsLike, this.temperatureMin,
      this.temperatureMax, this.pressure, this.humidity);
}
