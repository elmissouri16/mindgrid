import 'package:go_router/go_router.dart';
import 'package:mindgrid/models/note_model.dart';
import 'package:mindgrid/views/pages/note_page.dart';
import 'package:mindgrid/views/pages/note_viewer_page.dart';
import 'package:mindgrid/views/pages/notes_page.dart';
import 'dart:convert';

class Routes {
  static const String notes = 'notes';
  static const String note = 'note';
  static const String noteViewer = 'noteViewer';
}

final router = GoRouter(
  initialLocation: '/notes',
  routes: [
    GoRoute(
      path: '/notes',
      name: Routes.notes,
      builder: (context, state) => const NotesPage(),
    ),
    GoRoute(
      path: '/note',
      name: Routes.note,
      builder: (context, state) {
        final isEditing = state.uri.queryParameters['isEditing'] == 'true';
        final noteJson = state.uri.queryParameters['note'];
        final note = noteJson != null 
            ? NotesListData.fromJson(jsonDecode(noteJson))
            : null;
        return NotePage(
          isEditing: isEditing,
          note: note,
        );
      },
    ),
    GoRoute(
      path: '/viewer',
      name: Routes.noteViewer,
      builder: (context, state) {
        // get query parameters
        final noteId = state.uri.queryParameters['noteId'];
        return NoteViewerPage(noteId: int.parse(noteId!));
        // return const NoteViewerPage();
      },
    )
  ],
);
