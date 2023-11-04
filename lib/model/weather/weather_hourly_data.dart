class WeatherDataHourly {
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(
          hourly:
              List<Hourly>.from(json['hourly'].map((e) => Hourly.fromJson(e))));
}

class Hourly {
  int? _dt;
  int? _temp;

  List<Weather>? _weather;

  Hourly({
    int? dt,
    int? temp,
    List<Weather>? weather,
  }) {
    if (dt != null) {
      this._dt = dt;
    }
    if (temp != null) {
      this._temp = temp;
    }

    if (weather != null) {
      this._weather = weather;
    }
  }

  int? get dt => _dt;
  set dt(int? dt) => _dt = dt;
  int? get temp => _temp;
  set temp(int? temp) => _temp = temp;

  List<Weather>? get weather => _weather;
  set weather(List<Weather>? weather) => _weather = weather;

  Hourly.fromJson(Map<String, dynamic> json) {
    _dt = json['dt'];
    _temp = (json['temp'] as num?)?.round();

    if (json['weather'] != null) {
      _weather = <Weather>[];
      json['weather'].forEach((v) {
        _weather!.add(new Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this._dt;
    data['temp'] = this._temp;

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
