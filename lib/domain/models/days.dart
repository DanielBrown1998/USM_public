import 'dart:convert';

class Days {
  final String days;
  final Map<String, dynamic> hours;

  Days({required this.days, required this.hours});

  Days.fromMap(Map<String, dynamic> map)
      : days = map["days"],
        hours = json.decode(map["hours"]);
  Map<String, dynamic> toMap() {
    return {"days": days, "hours": hours};
  }
}
