import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NoteViewerPage extends ConsumerStatefulWidget {
  const NoteViewerPage({super.key});

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
      // appBar: AppBar(
      //   title: const Text('New Note'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.save),
      //       onPressed: () {
      //         final contents = _controller.document.toDelta().toJson();
      //         print(contents); // For testing
      //       },
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          // QuillToolbar.simple(
          //   controller: _controller,
          //   configurations: const QuillSimpleToolbarConfigurations(
          //     multiRowsDisplay: false,

          //   ),
          // ),
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
  }
}
