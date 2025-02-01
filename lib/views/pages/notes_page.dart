// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindgrid/core/router.dart';
import 'package:mindgrid/models/note_model.dart';
import 'package:mindgrid/providers/db_provider.dart';
import 'package:mindgrid/views/widgets/search_bar.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(dbProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove back button
          title: const CustomSearchBar(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(Routes.note);
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<List<NotesListData>>(
            stream: provider.watchAllNotes(),
            initialData: const [],
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.noteViewer, queryParameters: {
                          'noteId': snapshot.data![index].id.toString()
                        });
                      },
                      child: ShadCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Expanded(
                            //   child: Text(
                            //     demoNotes[index].content,
                            //     style: const TextStyle(fontSize: 12),
                            //     maxLines: 4,
                            //     overflow: TextOverflow.fade,
                            //   ),
                            // ),
                            Text(
                              Document.fromJson(
                                      jsonDecode(snapshot.data![index].content))
                                  .toPlainText(),
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
