import 'package:json_annotation/json_annotation.dart';

part 'blogModel.g.dart';

@JsonSerializable()

class BlogModel {
  String username;
  String body;
  String title;

  BlogModel({this.body, this.title, this.username});

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlogModelToJson(this);
    


}

