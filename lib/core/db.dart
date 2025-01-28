// import 'package:flutter/material.dart';
// import 'package:hive_ce/hive.dart';
// import 'package:mindgrid/models/note_model.dart';
// import 'package:path_provider/path_provider.dart';

// class Datasbase extends ChangeNotifier {
//   List<NoteModel> notes = [];
//   Future<void> init() async {
//       final dir = await getApplicationDocumentsDirectory();
     
    
//   }

//   void add(NoteModel note) {
//     notes.add(note);
//     notifyListeners();
//   }
//   void remove(NoteModel note) {
//     notes.remove(note);
//     notifyListeners();
//   }
//   void update(NoteModel note) {
//     final index = notes.indexWhere((element) => element.id == note.id);
//     notes[index] = note;
//     notifyListeners();
//   }

// }
  