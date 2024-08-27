import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_bloc_notes_app/bloc/notes_event.dart';
import 'package:using_bloc_notes_app/bloc/notes_state.dart';
import '../database/db_helper.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final DBHelper db;

  NotesBloc({required this.db}) : super(NotesInitialState()) {
    // Handle AddNoteEvent
    on<AddNoteEvent>((event, emit) async {
      emit(NotesLoadingState());
      try {
        int check = await db.addNotes(event.note);
        if (check > 0) {
          final allNotes = await db.getAllNotes();
          emit(NotesLoadedState(allNotes));
        } else {
          emit(NotesErrorState("Failed to add note"));
        }
      } catch (e) {
        emit(NotesErrorState("An error occurred: ${e.toString()}"));
      }
    });

    // Handle FetchAllNotesEvent
    on<FetchAllNotesEvent>((event, emit) async {
      emit(NotesLoadingState());
      try {
        var allNotes = await db.getAllNotes();
        emit(NotesLoadedState(allNotes));
      } catch (e) {
        emit(NotesErrorState("An error occurred: ${e.toString()}"));
      }
    });
  }
}
