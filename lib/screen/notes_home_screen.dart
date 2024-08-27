import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import '../database/db_helper.dart';
import 'create_notes_screen.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the event to load all notes
    context.read<NotesBloc>().add(FetchAllNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotesCreate()),
          );
        },
        label: const Row(
          children: [
            Icon(
              Icons.add,
              size: 30,
            ),
            Text(
              "Notes",
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesLoadedState) {
            if (state.notes.isEmpty) {
              return const Center(child: Text("No notes available"));
            } else {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.message),
                    onTap: () {
                      // Handle note tap (e.g., navigate to a detail or edit screen)
                    },
                  );
                },
              );
            }
          } else if (state is NotesErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("Unexpected error occurred"));
          }
        },
      ),
    );
  }
}
