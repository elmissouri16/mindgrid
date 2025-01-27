import 'package:go_router/go_router.dart';
import 'package:mindgrid/views/pages/note_page.dart';
import 'package:mindgrid/views/pages/notes_page.dart';

class Routes {
  static const String notes = 'notes';
  static const String note = 'note';
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
      path: '/note/:id',
      name: Routes.note,
      builder: (context, state) => const NotePage(),
    )
  ],
);
