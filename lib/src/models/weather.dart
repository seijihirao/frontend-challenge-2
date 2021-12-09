/// Weather object containing [city] contition
class Weather {
  final int id;
  final String city;
  List<WeatherCondition> conditions;

  Weather(this.id, this.city, this.conditions);

  /// We only need to compare [id] on equals
  @override
  bool operator ==(Object other) {
    return id == (other as Weather).id;
  }

  /// Create a hascode based on [id], [city] and [main] weather aspects
  @override
  int get hashCode => Object.hash(id, city, conditions[0].description);
}

/// Weather condition object, containint [temperature], [pressure] and [humidity]
class WeatherCondition {
  final String description;
  final String icon;
  final double temperature;
  final double feelsLike;
  final double temperatureMin;
  final double temperatureMax;
  final int pressure;
  final int humidity;

  WeatherCondition(
      this.description,
      this.icon,
      this.temperature,
      this.feelsLike,
      this.temperatureMin,
      this.temperatureMax,
      this.pressure,
      this.humidity);
}
