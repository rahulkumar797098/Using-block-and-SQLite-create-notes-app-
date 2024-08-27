
import 'package:using_bloc_notes_app/model/notes_model.dart';

abstract class NotesEvent {}


class FetchAllNotesEvent extends NotesEvent {}


// Add
class AddNoteEvent extends NotesEvent {
  final NotesModel note;
  AddNoteEvent(this.note);
}


// Update
class UpdateNoteEvent extends NotesEvent {
  final NotesModel note;
  UpdateNoteEvent(this.note);
}

// Delete
class DeleteNoteEvent extends NotesEvent {
  final int id;
  DeleteNoteEvent(this.id);

}
