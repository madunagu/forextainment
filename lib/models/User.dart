import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  int id;
  String firstName;
  String lastName;
  String avatar;
  String email;
  @JsonKey(name: 'email_verified_at')
  DateTime emailVerifiedAt;
  @JsonKey(name: 'assigned_at')
  DateTime assignedAt;
  String phone;
  String gender;
 
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'first_name' : firstName,
      'last_name' : lastName,
      'email': email,
      'phone': phone,
    };
  }
}
