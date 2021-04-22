import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Post {
  Post({
    this.id,
    this.category,
    this.body,
    this.status,
    this.values,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.outlook,
  });

  int id;
  String category;
  String body;
  List<String> values;
  String status;
  String image;
  String outlook;

  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

}
