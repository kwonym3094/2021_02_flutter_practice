import 'dart:convert';

import 'dart:ui';

Categories categoryFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoryToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.title,
    this.color,
  });

  String title;
  Color color;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        title: json["title"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "color": color,
      };
}
