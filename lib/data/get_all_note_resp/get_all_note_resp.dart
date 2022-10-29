import 'package:json_annotation/json_annotation.dart';
import 'package:noteapp_sample/data/note_model/note_model.dart';

part 'get_all_note_resp.g.dart';

@JsonSerializable()
class GetAllNoteResp {
  @JsonKey(name: 'data')
  List<NoteModel> data;

  GetAllNoteResp({this.data = const []});

  factory GetAllNoteResp.fromJson(Map<String, dynamic> json) {
    return _$GetAllNoteRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllNoteRespToJson(this);
}
