import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindgrid/models/note_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'db_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase db(Ref ref) => AppDatabase();




