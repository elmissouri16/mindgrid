import 'package:go_router/go_router.dart';
import 'package:mindgrid/views/pages/note_page.dart';
import 'package:mindgrid/views/pages/note_viewer_page.dart';
import 'package:mindgrid/views/pages/notes_page.dart';

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
      builder: (context, state) => const NotePage(),
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
