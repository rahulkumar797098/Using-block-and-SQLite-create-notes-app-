import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../model/notes_model.dart';

class NotesCreate extends StatefulWidget {
  const NotesCreate({super.key});

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
                final note = NotesModel(
                  title: titleController.text,
                  message: messageController.text,
                );
                context.read<NotesBloc>().add(AddNoteEvent(note));
                Navigator.pop(context);
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
      body: Column(
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
          ),
    );
  }
}
