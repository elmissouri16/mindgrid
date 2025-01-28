import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final contents = _controller.document.toDelta().toJson();
              print(contents); // For testing
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
  }
}
