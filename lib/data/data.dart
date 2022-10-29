import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:noteapp_sample/data/get_all_note_resp/get_all_note_resp.dart';
import 'package:noteapp_sample/data/note_model/note_model.dart';
import 'package:noteapp_sample/data/url.dart';

abstract class ApiCalls {
  Future<NoteModel?> createNote(NoteModel value);
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> updateNote(NoteModel value);
  Future<void> deleteNote(String id);
}

class NoteDB extends ApiCalls {
//   //--singleton
  NoteDB._internal();
  static NoteDB insatnce = NoteDB._internal();
  NoteDB factory() {
    return insatnce;
  }
// //--end_singleton

  final url = Url();
  final dio = Dio();

  ValueNotifier<List<NoteModel>> noteListNotifier = ValueNotifier([]);

  NoteDB() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }
  @override
  Future<NoteModel?> createNote(NoteModel value) async {
    try {
      final _result = await dio.post(
        url.createNote,
        data: value.toJson(),
      );
      final _resultAsjson = jsonDecode(_result.data);
      return NoteModel.fromJson(_resultAsjson);
    } on DioError catch (e) {
      print(e.response?.data);
      print(e);
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final result = await dio.get(
      url.getAllNote,
    );

    if (result != null) {
      final _resultAsjson = jsonDecode(result.data);
      final getNoteResp = GetAllNoteResp.fromJson(_resultAsjson);
      noteListNotifier.value.clear();
      noteListNotifier.value.addAll(getNoteResp.data.reversed);
      noteListNotifier.notifyListeners();
      return getNoteResp.data;
    } else {
      noteListNotifier.value.clear();
      return [];
    }
  }

  @override
  Future<NoteModel?> updateNote(NoteModel value) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }

  NoteModel? getNoteByID(String id) {
    try {
      noteListNotifier.value.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }
}
