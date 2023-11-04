class WeatherDataCurrent {
  final Current current;
  WeatherDataCurrent({required this.current});

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Current.fromJson(json['current']));
}

class Current {
  int? _temp;

  int? _humidity;

  int? _clouds;

  double? _windSpeed;

  List<Weather>? _weather;

  Current(
      {int? temp,
      int? humidity,
      int? clouds,
      double? windSpeed,
      List<Weather>? weather}) {
    if (temp != null) {
      this._temp = temp;
    }

    if (humidity != null) {
      this._humidity = humidity;
    }

    if (clouds != null) {
      this._clouds = clouds;
    }

    if (windSpeed != null) {
      this._windSpeed = windSpeed;
    }

    if (weather != null) {
      this._weather = weather;
    }
  }

  int? get temp => _temp;
  set temp(int? temp) => _temp = temp;

  int? get humidity => _humidity;
  set humidity(int? humidity) => _humidity = humidity;

  int? get clouds => _clouds;
  set clouds(int? clouds) => _clouds = clouds;

  double? get windSpeed => _windSpeed;
  set windSpeed(double? windSpeed) => _windSpeed = windSpeed;

  List<Weather>? get weather => _weather;
  set weather(List<Weather>? weather) => _weather = weather;

  Current.fromJson(Map<String, dynamic> json) {
    _temp = (json['temp'] as num?)?.round().toInt();

    _humidity = json['humidity'] as int?;

    _clouds = json['clouds'];

    _windSpeed = json['wind_speed'].toDouble();

    if (json['weather'] != null) {
      _weather = <Weather>[];
      json['weather'].forEach((v) {
        _weather!.add(new Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['temp'] = this._temp;

    data['humidity'] = this._humidity;

    data['clouds'] = this._clouds;

    data['wind_speed'] = this._windSpeed;

    if (this._weather != null) {
      data['weather'] = this._weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weather {
  int? _id;
  String? _main;
  String? _description;
  String? _icon;

  Weather({int? id, String? main, String? description, String? icon}) {
    if (id != null) {
      this._id = id;
    }
    if (main != null) {
      this._main = main;
    }
    if (description != null) {
      this._description = description;
    }
    if (icon != null) {
      this._icon = icon;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get main => _main;
  set main(String? main) => _main = main;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get icon => _icon;
  set icon(String? icon) => _icon = icon;

  Weather.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['main'] = this._main;
    data['description'] = this._description;
    data['icon'] = this._icon;
    return data;
  }
}
