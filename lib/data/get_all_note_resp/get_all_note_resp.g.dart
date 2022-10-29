// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_note_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllNoteResp _$GetAllNoteRespFromJson(Map<String, dynamic> json) =>
    GetAllNoteResp(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetAllNoteRespToJson(GetAllNoteResp instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
