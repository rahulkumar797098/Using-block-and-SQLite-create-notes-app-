import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import '../model/notes_model.dart';

class NotesCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesCreate();
}

class _NotesCreate extends State<NotesCreate> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Write Notes",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    messageController.text.isNotEmpty) {
                  final note = NotesModel(
                    title: titleController.text,
                    message: messageController.text,
                  );
                  context.read<NotesBloc>().add(AddNoteEvent(note));
                }
              },
              icon: const Icon(
                Icons.check_circle_outline_rounded,
                size: 40,
              ),
              splashColor: Colors.orange,
            ),
          ],
        ),
      ),
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Note added successfully")),
            );
            Navigator.pop(context); // Go back to the previous screen
          } else if (state is NotesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is NotesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 8, right: 10),
                child: TextField(
                  controller: titleController,
                  minLines: 1,
                  maxLines: 2,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Write Title",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 10),
                child: TextField(
                  controller: messageController,
                  minLines: 1,
                  maxLines: 10,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write Notes",
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
