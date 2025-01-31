import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mindgrid/providers/db_provider.dart';

class NotePage extends ConsumerStatefulWidget {
  const NotePage({super.key});

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.read(dbProviderProvider);
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Note'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  final contents = _controller.document.toDelta().toJson();
                  provider.insertNote(
                    'some title',
                    jsonEncode(contents),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              QuillToolbar.simple(
                controller: _controller,
                configurations: const QuillSimpleToolbarConfigurations(
                  multiRowsDisplay: false,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: QuillEditor.basic(
                    controller: _controller,
                    focusNode: _focusNode,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
