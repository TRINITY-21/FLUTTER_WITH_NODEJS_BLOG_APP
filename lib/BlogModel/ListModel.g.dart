// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListModel _$ListModelFromJson(Map<String, dynamic> json) {
  return ListModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BlogModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListModelToJson(ListModel instance) => <String, dynamic>{
      'data': instance.data,
    };
