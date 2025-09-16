import 'days.dart';

class Hours {
  final Days days;
  final int end;
  final int start;
  Hours({required this.start, required this.end, required this.days});

  Hours.fromMap(Map<String, dynamic> map)
      : days = Days.fromMap(map["days"]),
        start = map["start"],
        end = map["end"];

  Map<String, dynamic> toMap() {  
    return {"days": days.toMap(), "start": start, "end": end};
  }
}
