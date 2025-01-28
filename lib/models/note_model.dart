import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
part 'note_model.g.dart';

// part 'note_model.g.dart';
class NotesList extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength()();
  TextColumn get content => text().named('body')();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

@DriftDatabase(tables: [NotesList])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'notes_db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<List<NotesListData>> getAllNotes() => select(notesList).get();
  Future<void> insertNote(String title, String content) => into(notesList)
      .insert(NotesListCompanion.insert(title: title, content: content));
  Future<void> updateNote(Insertable<NotesListData> note) =>
      update(notesList).replace(note);
  Future<void> deleteNote(Insertable<NotesListData> note) =>
      delete(notesList).delete(note);
  Stream<List<NotesListData>> watchAllNotes() => select(notesList).watch();
}
