import 'file:///D:/kwchen/flutter/flutter_hello/lib/model/address.dart';
import 'package:json_annotation/json_annotation.dart';

/// @Description
/// @outhor chenkw
/// @create 2020-05-21 15:21

part 'user.g.dart';


///  explicitToJson: true 会将address输出成json字符串形式
@JsonSerializable(explicitToJson: true)
class User {

  User(this.name, this.email, this.nick);

  String name;
  String email;

  @JsonKey(name: "nick_name")
  String nick;

  @JsonKey(name: "Age")
  int age;

  Address address;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}