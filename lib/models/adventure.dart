import 'dart:convert';

Adventure adventureFromMap(String str) => Adventure.fromMap(json.decode(str));

String adventureToMap(Adventure data) => json.encode(data.toMap());

class Adventure {
  int? id;
  String title;
  String date;
  String place;
  String? img;
  bool? add;

  Adventure({
    this.id,
    required this.title,
    required this.date,
    required this.place,
    this.img,
    this.add,
  });

  factory Adventure.fromMap(Map<String, dynamic> json) => Adventure(
        id: json["id"],
        title: json["title"],
        date: (json["date"]),
        place: json["place"],
        img: json["img"],
        // add: json["add"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "date": date,
        "place": place,
        "img": img,
        // "add": add,
      };
}
