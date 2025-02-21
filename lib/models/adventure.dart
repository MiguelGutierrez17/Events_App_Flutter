import 'dart:convert';

Adventure adventureFromMap(String str) => Adventure.fromMap(json.decode(str));

String adventureToMap(Adventure data) => json.encode(data.toMap());

class Adventure {
  String title;
  DateTime date;
  String place;
  String? img;

  Adventure({
    required this.title,
    required this.date,
    required this.place,
    this.img,
  });

  factory Adventure.fromMap(Map<String, dynamic> json) => Adventure(
        title: json["title"],
        date: DateTime.parse(json["date"]),
        place: json["place"],
        img: json["img"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "place": place,
        "img": img,
      };
}
