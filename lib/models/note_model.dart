import 'package:json_annotation/json_annotation.dart';
part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  final String title;
  final String content;
  final String date;
  NoteModel({required this.title, required this.content, required this.date});
  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}

final List<NoteModel> demoNotes = [
  NoteModel(
    title: 'Project Roadmap',
    content: 'Q1: Feature A, Q2: Feature B, Q3: Launch',
    date: '2024-02-01',
  ),
  NoteModel(
    title: 'Book Recommendations',
    content: 'Clean Code, Design Patterns, Pragmatic Programmer',
    date: '2024-02-02',
  ),
  NoteModel(
    title: 'Weekly Goals',
    content: 'Complete API integration, Write tests, Update docs',
    date: '2024-02-03',
  ),
  NoteModel(
    title: 'Gym Schedule',
    content: 'Mon: Arms, Wed: Legs, Fri: Cardio',
    date: '2024-02-04',
  ),
  NoteModel(
    title: 'Recipe Ideas',
    content: 'Pasta carbonara, Chicken curry, Vegetable soup',
    date: '2024-02-05',
  ),
  NoteModel(
    title: 'Birthday Gifts',
    content: 'Mom: scarf, Dad: book, Sister: headphones',
    date: '2024-02-06',
  ),
  NoteModel(
    title: 'Movie Watchlist',
    content: 'Inception, The Matrix, Interstellar',
    date: '2024-02-07',
  ),
  NoteModel(
    title: 'Learning Goals',
    content: 'Flutter animations, State management, Testing',
    date: '2024-02-08',
  ),
  NoteModel(
    title: 'Travel Plans',
    content: 'Book flights, Reserve hotel, Plan itinerary',
    date: '2024-02-09',
  ),
  NoteModel(
    title: 'Home Maintenance',
    content: 'Fix leak, Paint walls, Clean gutters',
    date: '2024-02-10',
  ),
];
