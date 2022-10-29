import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:noteapp_sample/data/data.dart';
import 'package:noteapp_sample/data/note_model/note_model.dart';

enum ActionType {
  addNote,
  editNote,
}

class ScreenAddNotes extends StatelessWidget {
  final ActionType type;
  String? id;
  ScreenAddNotes({
    Key? key,
    required this.type,
    this.id,
  }) : super(key: key);
  Widget get saveButton => TextButton.icon(
        onPressed: () {
          switch (type) {
            case ActionType.addNote:
              saveNote();
              break;
            case ActionType.editNote:
              // Edit Note
              break;
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: const Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ),
      );
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    if (type == ActionType.editNote) {
      if (id == null) {
        Navigator.of(context).pop();
      }
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(type.name.toUpperCase()),
        actions: [
          saveButton,
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _contentController,
              maxLines: 4,
              maxLength: 100,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Content',
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;

    final _newNote = NoteModel.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content);
    final newNote = await NoteDB().createNote(_newNote);
    if (newNote != null) {
      print('Note Saved');
      Navigator.of(_scaffoldKey.currentContext!).pop();
    } else {
      print('Error while saving');
    }
  }
}
