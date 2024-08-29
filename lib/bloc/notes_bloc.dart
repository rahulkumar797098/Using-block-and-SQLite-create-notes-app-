import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/db_helper.dart';
import 'notes_event.dart';
import 'notes_event.dart';
import 'notes_event.dart';
import 'notes_event.dart';
import 'notes_state.dart';

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

    // Handle DeleteNoteEvent
    on<DeleteNoteEvent>((event, emit) async {
      emit(NotesLoadingState());
      try {
        int check = await db.deleteNotes(event.id);
        if (check > 0) {
          final allNotes = await db.getAllNotes();
          emit(NotesLoadedState(allNotes));
        } else {
          emit(NotesErrorState("Failed to delete note"));
        }
      } catch (e) {
        emit(NotesErrorState("An error occurred: ${e.toString()}"));
      }
    });

    // Handle UpdateNoteEvent
    on<UpdateNoteEvent>((event, emit) async {
      emit(NotesLoadingState());
      try {
        int check = await db.updateNotes(event.note);
        if (check > 0) {
          final allNotes = await db.getAllNotes();
          emit(NotesLoadedState(allNotes));
        } else {
          emit(NotesErrorState("Failed to update note"));
        }
      } catch (e) {
        emit(NotesErrorState("An error occurred: ${e.toString()}"));
      }
    });
  }
}
