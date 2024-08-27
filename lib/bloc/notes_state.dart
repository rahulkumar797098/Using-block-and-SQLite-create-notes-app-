import 'package:using_bloc_notes_app/model/notes_model.dart';

abstract class NotesState {}


// Initial
class NotesInitialState extends NotesState {}

// Loading
class NotesLoadingState extends NotesState {}

// Loaded
class NotesLoadedState extends NotesState {
  final List<NotesModel> notes;
  NotesLoadedState(this.notes);
}


// error
class NotesErrorState extends NotesState {
  final String message;
  NotesErrorState(this.message);
}
