import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mindgrid/models/note_model.dart';
import 'package:mindgrid/providers/db_provider.dart';

class NoteViewerPage extends ConsumerStatefulWidget {
  final int? noteId;
  const NoteViewerPage({super.key, this.noteId});

  @override
  ConsumerState<NoteViewerPage> createState() => _NoteViewerPageState();
}

class _NoteViewerPageState extends ConsumerState<NoteViewerPage> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _controller.readOnly = true;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(dbProvider);

          return StreamBuilder<NotesListData?>(
              stream: provider.watchNoteById(widget.noteId!),
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Note not found'),
                  );
                }
                _controller.document =
                    Document.fromJson(jsonDecode(snapshot.data!.content));
                return Center(
                  child: Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: QuillEditor.basic(
                        controller: _controller,
                        focusNode: _focusNode,
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
