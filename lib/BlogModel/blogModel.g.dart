// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) {
  return BlogModel(
    body: json['body'] as String,
    title: json['title'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      'username': instance.username,
      'body': instance.body,
      'title': instance.title,
    };
