import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mindgrid/providers/db_provider.dart';
import 'package:mindgrid/models/note_model.dart';

class NotePage extends ConsumerStatefulWidget {
  final bool isEditing;
  final NotesListData? note;


  const NotePage({
    super.key, 
    required this.isEditing,
    this.note,
  });

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.readOnly = !widget.isEditing;
    if (widget.note != null) {
      _controller.document = Document.fromJson(
        jsonDecode(widget.note!.content),
      );
      _titleController.text = widget.note!.title;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildEditor() {
    return Column(
      children: [
        if (!_controller.readOnly)
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.read(dbProvider);
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter title',
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              IconButton(
                icon:
                    Icon(_controller.readOnly ? Icons.visibility : Icons.edit),
                onPressed: () {
                  setState(() {
                    _controller.readOnly = !_controller.readOnly;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  final contents = _controller.document.toDelta().toJson();
                  final title = _titleController.text.isEmpty
                      ? 'Untitled'
                      : _titleController.text;
                      
                  if (widget.note != null) {
                    // Update existing note
                    provider.updateNote(
                      widget.note!.copyWith(
                        title: title,
                        content: jsonEncode(contents),
                      ),
                    );
                  } else {
                    // Insert new note
                    provider.insertNote(
                      title,
                      jsonEncode(contents),
                    );
                  }
                },
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                // Wide screen - show split view
                return Row(
                  children: [
                    Expanded(
                      child: _buildEditor(),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: QuillEditor.basic(
                          controller: _controller,
                          focusNode: FocusNode(),
                        ),
                      ),
                    ),
                  ],
                );
              }
              // Narrow screen - show single view with toggle
              return _buildEditor();
            },
          ),
        );
      },
    );
  }
}
