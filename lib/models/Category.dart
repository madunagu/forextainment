import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Category {
  Category({
    this.id,
    this.name,
    this.count,
    this.link,
  });

  int id;
  String name;
  int count;
  String link;
}
