import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_bloc_notes_app/screen/edit_notes_screen.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
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
            MaterialPageRoute(builder: (context) => const NotesCreate()),
          );
        },
        backgroundColor: Colors.blueAccent.shade200,
        foregroundColor: Colors.white,
        label: const Row(
          children: [
            Icon(
              Icons.add,
              size: 30,
              shadows: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black,
                    offset: Offset(1.0, 1.0))
              ],
            ),
            Text(
              "Notes",
              style: TextStyle(fontSize: 25, shadows: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(1.0, 1.0))
              ]),
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
          // Notes is Loading Circular Progress Indicator show
          if (state is NotesLoadingState) {
            return const Center(child: CircularProgressIndicator());

            //   Notes is Loaded
          } else if (state is NotesLoadedState) {
            // Notes is empty
            if (state.notes.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/folder.png",
                    height: 50,
                  ),
                  const Text("No notes available"),
                ],
              ));
              //   Data show here
            } else {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  // store data in note variable
                  final note = state.notes[index];
                  return Card(
                    child: ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.message),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Delete
                          IconButton(
                            onPressed: () {
                              context
                                  .read<NotesBloc>()
                                  .add(DeleteNoteEvent(note.id!));
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 25,
                              color: Colors.red,
                            ),
                          ),

                          // Edit
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditNotesScreen(notes: note)));
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 25,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            //   if error show
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
